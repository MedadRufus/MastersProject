#include "ms8607.h"
#include <Wire.h>

// HSENSOR device address
#define HSENSOR_ADDR 0x40 // 0b1000000

// HSENSOR device commands
#define HSENSOR_RESET_COMMAND 0xFE
#define HSENSOR_READ_HUMIDITY_W_HOLD_COMMAND 0xE5
#define HSENSOR_READ_HUMIDITY_WO_HOLD_COMMAND 0xF5
#define HSENSOR_READ_SERIAL_FIRST_8BYTES_COMMAND 0xFA0F
#define HSENSOR_READ_SERIAL_LAST_6BYTES_COMMAND 0xFCC9
#define HSENSOR_WRITE_USER_REG_COMMAND 0xE6
#define HSENSOR_READ_USER_REG_COMMAND 0xE7

// Processing constants
#define HSENSOR_TEMPERATURE_COEFFICIENT (float)(-0.15)
#define HSENSOR_CONSTANT_A (float)(8.1332)
#define HSENSOR_CONSTANT_B (float)(1762.39)
#define HSENSOR_CONSTANT_C (float)(235.66)

// Coefficients for temperature computation
#define TEMPERATURE_COEFF_MUL (175.72)
#define TEMPERATURE_COEFF_ADD (-46.85)

// Coefficients for relative humidity computation
#define HUMIDITY_COEFF_MUL (125)
#define HUMIDITY_COEFF_ADD (-6)

// Conversion timings
#define HSENSOR_CONVERSION_TIME_12b 160
#define HSENSOR_CONVERSION_TIME_10b 50
#define HSENSOR_CONVERSION_TIME_8b 30
#define HSENSOR_CONVERSION_TIME_11b 90

#define HSENSOR_RESET_TIME 15 // ms value

// HSENSOR User Register masks and bit position
#define HSENSOR_USER_REG_RESOLUTION_MASK 0x81
#define HSENSOR_USER_REG_END_OF_BATTERY_MASK 0x40
#define HSENSOR_USER_REG_ENABLE_ONCHIP_HEATER_MASK 0x4
#define HSENSOR_USER_REG_DISABLE_OTP_RELOAD_MASK 0x2
#define HSENSOR_USER_REG_RESERVED_MASK                                         \
  (~(HSENSOR_USER_REG_RESOLUTION_MASK | HSENSOR_USER_REG_END_OF_BATTERY_MASK | \
     HSENSOR_USER_REG_ENABLE_ONCHIP_HEATER_MASK |                              \
     HSENSOR_USER_REG_DISABLE_OTP_RELOAD_MASK))

// HTU User Register values
// Resolution
#define HSENSOR_USER_REG_RESOLUTION_12b 0x00
#define HSENSOR_USER_REG_RESOLUTION_11b 0x81
#define HSENSOR_USER_REG_RESOLUTION_10b 0x80
#define HSENSOR_USER_REG_RESOLUTION_8b 0x01

// End of battery status
#define HSENSOR_USER_REG_END_OF_BATTERY_VDD_ABOVE_2_25V 0x00
#define HSENSOR_USER_REG_END_OF_BATTERY_VDD_BELOW_2_25V 0x40
// Enable on chip heater
#define HSENSOR_USER_REG_ONCHIP_HEATER_ENABLE 0x04
#define HSENSOR_USER_REG_OTP_RELOAD_DISABLE 0x02

// PSENSOR device address
#define PSENSOR_ADDR 0x76 // 0b1110110

// PSENSOR device commands
#define PSENSOR_RESET_COMMAND 0x1E
#define PSENSOR_START_PRESSURE_ADC_CONVERSION 0x40
#define PSENSOR_START_TEMPERATURE_ADC_CONVERSION 0x50
#define PSENSOR_READ_ADC 0x00

#define PSENSOR_CONVERSION_OSR_MASK 0x0F

#define PSENSOR_CONVERSION_TIME_OSR_256 1
#define PSENSOR_CONVERSION_TIME_OSR_512 2
#define PSENSOR_CONVERSION_TIME_OSR_1024 3
#define PSENSOR_CONVERSION_TIME_OSR_2048 5
#define PSENSOR_CONVERSION_TIME_OSR_4096 9
#define PSENSOR_CONVERSION_TIME_OSR_8192 18

// PSENSOR commands
#define PROM_ADDRESS_READ_ADDRESS_0 0xA0
#define PROM_ADDRESS_READ_ADDRESS_1 0xA2
#define PROM_ADDRESS_READ_ADDRESS_2 0xA4
#define PROM_ADDRESS_READ_ADDRESS_3 0xA6
#define PROM_ADDRESS_READ_ADDRESS_4 0xA8
#define PROM_ADDRESS_READ_ADDRESS_5 0xAA
#define PROM_ADDRESS_READ_ADDRESS_6 0xAC
#define PROM_ADDRESS_READ_ADDRESS_7 0xAE

// Coefficients indexes for temperature and pressure computation
#define CRC_INDEX 0
#define PRESSURE_SENSITIVITY_INDEX 1
#define PRESSURE_OFFSET_INDEX 2
#define TEMP_COEFF_OF_PRESSURE_SENSITIVITY_INDEX 3
#define TEMP_COEFF_OF_PRESSURE_OFFSET_INDEX 4
#define REFERENCE_TEMPERATURE_INDEX 5
#define TEMP_COEFF_OF_TEMPERATURE_INDEX 6
#define COEFFICIENT_NUMBERS 7

#define MAX_CONVERSION_TIME HSENSOR_CONVERSION_TIME_12b

uint16_t eeprom_coeff[COEFFICIENT_NUMBERS + 1];
enum ms8607_pressure_resolution psensor_resolution_osr;

ms8607::ms8607(void)
    : psensor_conversion_time{
          PSENSOR_CONVERSION_TIME_OSR_256,  PSENSOR_CONVERSION_TIME_OSR_512,
          PSENSOR_CONVERSION_TIME_OSR_1024, PSENSOR_CONVERSION_TIME_OSR_2048,
          PSENSOR_CONVERSION_TIME_OSR_4096, PSENSOR_CONVERSION_TIME_OSR_8192} {

  hsensor_conversion_time = HSENSOR_CONVERSION_TIME_12b;
  hsensor_i2c_master_mode = ms8607_i2c_no_hold;
  hsensor_heater_on = false;
  psensor_coeff_read = false;
}

/**
 * \brief Perform initial configuration. Has to be called once.
 */
void ms8607::begin() {
  Wire.begin();
}

/**
 * \brief Check whether MS8607 device is connected
 *
 * \return bool : status of MS8607
 *       - true : Device is present
 *       - false : Device is not acknowledging I2C address
  */
bool ms8607::is_connected(void) {
  return (hsensor_is_connected() && psensor_is_connected());
}

/**
 * \brief Reset the MS8607 device
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_i2c_transfer_error : Problem with i2c transfer
 *       - ms8607_status_no_i2c_acknowledge : I2C did not acknowledge
 */
enum ms8607_status ms8607::reset(void) {
  enum ms8607_status status;

  status = hsensor_reset();
  if (status != ms8607_status_ok)
    return status;
  status = psensor_reset();
  if (status != ms8607_status_ok)
    return status;

  return ms8607_status_ok;
}

/**
 * \brief Set Humidity sensor ADC resolution.
 *
 * \param[in] ms8607_i2c_master_mode : I2C mode
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok
 */
void ms8607::set_humidity_i2c_master_mode(
    enum ms8607_humidity_i2c_master_mode mode) {
  hsensor_i2c_master_mode = mode;
}

/**
 * \brief Provide battery status
 *
 * \param[out] ms8607_battery_status* : Battery status
 *                      - ms8607_battery_ok,
 *                      - ms8607_battery_low
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_i2c_transfer_error : Problem with i2c transfer
 *       - ms8607_status_no_i2c_acknowledge : I2C did not acknowledge
 */
enum ms8607_status ms8607::get_battery_status(enum ms8607_battery_status *bat) {
  enum ms8607_status status;
  uint8_t reg_value;

  status = hsensor_read_user_register(&reg_value);
  if (status != ms8607_status_ok)
    return status;

  if (reg_value & HSENSOR_USER_REG_END_OF_BATTERY_VDD_BELOW_2_25V)
    *bat = ms8607_battery_low;
  else
    *bat = ms8607_battery_ok;

  return status;
}

/**
 * \brief Enable heater
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_i2c_transfer_error : Problem with i2c transfer
 *       - ms8607_status_no_i2c_acknowledge : I2C did not acknowledge
 */
enum ms8607_status ms8607::enable_heater(void) {
  enum ms8607_status status;
  uint8_t reg_value;

  status = hsensor_read_user_register(&reg_value);
  if (status != ms8607_status_ok)
    return status;

  // Clear the resolution bits
  reg_value |= HSENSOR_USER_REG_ONCHIP_HEATER_ENABLE;
  hsensor_heater_on = true;

  status = hsensor_write_user_register(reg_value);

  return status;
}

/**
 * \brief Disable heater
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_i2c_transfer_error : Problem with i2c transfer
 *       - ms8607_status_no_i2c_acknowledge : I2C did not acknowledge
 */
enum ms8607_status ms8607::disable_heater(void) {
  enum ms8607_status status;
  uint8_t reg_value;

  status = hsensor_read_user_register(&reg_value);
  if (status != ms8607_status_ok)
    return status;

  // Clear the resolution bits
  reg_value &= ~HSENSOR_USER_REG_ONCHIP_HEATER_ENABLE;
  hsensor_heater_on = false;

  status = hsensor_write_user_register(reg_value);

  return status;
}

/**
 * \brief Get heater status
 *
 * \param[in] ms8607_heater_status* : Return heater status (above or below 2.5V)
 *	                    - ms8607_heater_off,
 *                      - ms8607_heater_on
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_i2c_transfer_error : Problem with i2c transfer
 *       - ms8607_status_no_i2c_acknowledge : I2C did not acknowledge
 */
enum ms8607_status
ms8607::get_heater_status(enum ms8607_heater_status *heater) {
  enum ms8607_status status;
  uint8_t reg_value;

  status = hsensor_read_user_register(&reg_value);
  if (status != ms8607_status_ok)
    return status;

  // Get the heater enable bit in reg_value
  if (reg_value & HSENSOR_USER_REG_ONCHIP_HEATER_ENABLE)
    *heater = ms8607_heater_on;
  else
    *heater = ms8607_heater_off;

  return status;
}

/**
 * \brief Reads the temperature, pressure and relative humidity value.
 *
 * \param[out] float* : degC temperature value
 * \param[out] float* : mbar pressure value
 * \param[out] float* : %RH Relative Humidity value
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_i2c_transfer_error : Problem with i2c transfer
 *       - ms8607_status_no_i2c_acknowledge : I2C did not acknowledge
 *       - ms8607_status_crc_error : CRC check error
 */
enum ms8607_status
ms8607::read_temperature_pressure_humidity(float *t, float *p, float *h) {
  enum ms8607_status status;

  status = psensor_read_pressure_and_temperature(t, p);
  if (status != ms8607_status_ok)
    return status;

  status = hsensor_read_relative_humidity(h);
  if (status != ms8607_status_ok)
    return status;

  return ms8607_status_ok;
}

/******************** Functions from humidity sensor ********************/

/**
 * \brief Check whether humidity sensor is connected
 *
 * \return bool : status of humidity sensor
 *       - true : Device is present
 *       - false : Device is not acknowledging I2C address
  */
bool ms8607::hsensor_is_connected(void) {
  Wire.beginTransmission(HSENSOR_ADDR);
  return (Wire.endTransmission() == 0);
}

/**
 * \brief Reset the humidity sensor part
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_i2c_transfer_error : Problem with i2c transfer
 *       - ms8607_status_no_i2c_acknowledge : I2C did not acknowledge
 */
enum ms8607_status ms8607::hsensor_reset(void) {
  enum ms8607_status status = ms8607_status_ok;

  Wire.beginTransmission((uint8_t)HSENSOR_ADDR);
  Wire.write((uint8_t)HSENSOR_RESET_COMMAND);
  Wire.endTransmission();

  if (status != ms8607_status_ok)
    return status;

  hsensor_conversion_time = HSENSOR_CONVERSION_TIME_12b;
  vTaskDelay(pdMS_TO_TICKS(HSENSOR_RESET_TIME));

  return ms8607_status_ok;
}

/**
 * \brief Check CRC
 *
 * \param[in] uint16_t : variable on which to check CRC
 * \param[in] uint8_t : CRC value
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : CRC check is OK
 *       - ms8607_status_crc_error : CRC check error
 */
enum ms8607_status ms8607::hsensor_crc_check(uint16_t value, uint8_t crc) {
  uint32_t polynom = 0x988000; // x^8 + x^5 + x^4 + 1
  uint32_t msb = 0x800000;
  uint32_t mask = 0xFF8000;
  uint32_t result = (uint32_t)value << 8; // Pad with zeros as specified in spec

  while (msb != 0x80) {

    // Check if msb of current value is 1 and apply XOR mask
    if (result & msb)
      result = ((result ^ polynom) & mask) | (result & ~mask);

    // Shift by one
    msb >>= 1;
    mask >>= 1;
    polynom >>= 1;
  }
  if (result == crc)
    return ms8607_status_ok;
  else
    return ms8607_status_crc_error;
}

/**
 * \brief Reads the MS8607 humidity user register.
 *
 * \param[out] uint8_t* : Storage of user register value
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_i2c_transfer_error : Problem with i2c transfer
 *       - ms8607_status_no_i2c_acknowledge : I2C did not acknowledge
 */
enum ms8607_status ms8607::hsensor_read_user_register(uint8_t *value) {
  enum ms8607_status status = ms8607_status_ok;
  uint8_t i2c_status;
  uint8_t buffer[1];
  buffer[0] = 0;

  // Send the Read Register Command
  Wire.beginTransmission((uint8_t)HSENSOR_ADDR);
  Wire.write(HSENSOR_READ_USER_REG_COMMAND);
  i2c_status = Wire.endTransmission();

  Wire.requestFrom((uint8_t)HSENSOR_ADDR, 1U);
  buffer[0] = Wire.read();

  if (status != ms8607_status_ok)
    return status;

  if (i2c_status == i2c_status_err_overflow)
    return ms8607_status_no_i2c_acknowledge;
  if (i2c_status != i2c_status_ok)
    return ms8607_status_i2c_transfer_error;

  *value = buffer[0];

  return ms8607_status_ok;
}

/**
 * \brief Writes the MS8607 humidity user register with value
 *        Will read and keep the unreserved bits of the register
 *
 * \param[in] uint8_t : Register value to be set.
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_i2c_transfer_error : Problem with i2c transfer
 *       - ms8607_status_no_i2c_acknowledge : I2C did not acknowledge
 */
enum ms8607_status ms8607::hsensor_write_user_register(uint8_t value) {
  enum ms8607_status status;
  uint8_t i2c_status;
  uint8_t reg;
  uint8_t data[2];

  status = hsensor_read_user_register(&reg);
  if (status != ms8607_status_ok)
    return status;

  // Clear bits of reg that are not reserved
  reg &= HSENSOR_USER_REG_RESERVED_MASK;
  // Set bits from value that are not reserved
  reg |= (value & ~HSENSOR_USER_REG_RESERVED_MASK);

  data[0] = HSENSOR_WRITE_USER_REG_COMMAND;
  data[1] = reg;

  Wire.beginTransmission((uint8_t)HSENSOR_ADDR);
  Wire.write(HSENSOR_WRITE_USER_REG_COMMAND);
  Wire.write(reg);
  i2c_status = Wire.endTransmission();

  /* Do the transfer */
  if (i2c_status == i2c_status_err_overflow)
    return ms8607_status_no_i2c_acknowledge;
  if (i2c_status != i2c_status_ok)
    return ms8607_status_i2c_transfer_error;

  return ms8607_status_ok;
}

/**
 * \brief Set humidity ADC resolution.
 *
 * \param[in] ms8607_humidity_resolution : Resolution requested
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_i2c_transfer_error : Problem with i2c transfer
 *       - ms8607_status_no_i2c_acknowledge : I2C did not acknowledge
 *       - ms8607_status_crc_error : CRC check error
 */
enum ms8607_status
ms8607::set_humidity_resolution(enum ms8607_humidity_resolution res) {
  enum ms8607_status status;
  uint8_t reg_value, tmp = 0;
  uint32_t conversion_time = HSENSOR_CONVERSION_TIME_12b;

  if (res == ms8607_humidity_resolution_12b) {
    tmp = HSENSOR_USER_REG_RESOLUTION_12b;
    conversion_time = HSENSOR_CONVERSION_TIME_12b;
  } else if (res == ms8607_humidity_resolution_10b) {
    tmp = HSENSOR_USER_REG_RESOLUTION_10b;
    conversion_time = HSENSOR_CONVERSION_TIME_10b;
  } else if (res == ms8607_humidity_resolution_8b) {
    tmp = HSENSOR_USER_REG_RESOLUTION_8b;
    conversion_time = HSENSOR_CONVERSION_TIME_8b;
  } else if (res == ms8607_humidity_resolution_11b) {
    tmp = HSENSOR_USER_REG_RESOLUTION_11b;
    conversion_time = HSENSOR_CONVERSION_TIME_11b;
  }

  status = hsensor_read_user_register(&reg_value);
  if (status != ms8607_status_ok)
    return status;

  // Clear the resolution bits
  reg_value &= ~HSENSOR_USER_REG_RESOLUTION_MASK;
  reg_value |= tmp & HSENSOR_USER_REG_RESOLUTION_MASK;

  hsensor_conversion_time = conversion_time;

  status = hsensor_write_user_register(reg_value);

  return status;
}

/**
 * \brief Reads the relative humidity ADC value
 *
 * \param[out] uint16_t* : Relative humidity ADC value.
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_i2c_transfer_error : Problem with i2c transfer
 *       - ms8607_status_no_i2c_acknowledge : I2C did not acknowledge
 *       - ms8607_status_crc_error : CRC check error
 */
enum ms8607_status
ms8607::hsensor_humidity_conversion_and_read_adc(uint16_t *adc) {
  enum ms8607_status status = ms8607_status_ok;
  uint8_t i2c_status;
  uint16_t _adc;
  uint8_t buffer[3];
  uint8_t crc;
  uint8_t i;

  /* Read data */
  Wire.beginTransmission((uint8_t)HSENSOR_ADDR);

  if (hsensor_i2c_master_mode == ms8607_i2c_hold) {
    Wire.write(HSENSOR_READ_HUMIDITY_W_HOLD_COMMAND);
    i2c_status = Wire.endTransmission();
  } else {
    Wire.write(HSENSOR_READ_HUMIDITY_WO_HOLD_COMMAND);
    i2c_status = Wire.endTransmission();
    // delay depending on resolution
    vTaskDelay(pdMS_TO_TICKS(hsensor_conversion_time));
  }
  Wire.requestFrom((uint8_t)HSENSOR_ADDR, 3U);
  for (i = 0; i < 3; i++) {
    buffer[i] = Wire.read();
  }

  if (status != ms8607_status_ok)
    return status;

  if (i2c_status == i2c_status_err_overflow)
    return ms8607_status_no_i2c_acknowledge;
  if (i2c_status != i2c_status_ok)
    return ms8607_status_i2c_transfer_error;

  _adc = (buffer[0] << 8) | buffer[1];
  crc = buffer[2];

  // compute CRC
  status = hsensor_crc_check(_adc, crc);
   if (status != ms8607_status_ok)
     return status;

  *adc = _adc;

  return status;
}

/**
 * \brief Reads the relative humidity value.
 *
 * \param[out] float* : %RH Relative Humidity value
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_i2c_transfer_error : Problem with i2c transfer
 *       - ms8607_status_no_i2c_acknowledge : I2C did not acknowledge
 *       - ms8607_status_crc_error : CRC check error
 */
enum ms8607_status ms8607::hsensor_read_relative_humidity(float *humidity) {
  enum ms8607_status status;
  uint16_t adc;

  status = hsensor_humidity_conversion_and_read_adc(&adc);
  if (status != ms8607_status_ok)
    return status;

  // Perform conversion function
  *humidity =
      (float)adc * HUMIDITY_COEFF_MUL / (1UL << 16) + HUMIDITY_COEFF_ADD;

  return status;
}

/**
 * \brief Returns result of compensated humidity
 *        Note : This function shall only be used when the heater is OFF. It
 * will return an error otherwise.
 *
 * \param[in] float - Actual temperature measured (degC)
 * \param[in] float - Actual relative humidity measured (%RH)
 * \param[out] float *- Compensated humidity (%RH).
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_heater_on_error : Cannot compute compensated humidity
 * because heater is on
 */
enum ms8607_status
ms8607::get_compensated_humidity(float temperature, float relative_humidity,
                                 float *compensated_humidity) {
  if (hsensor_heater_on)
    return ms8607_status_heater_on_error;

  *compensated_humidity =
      (relative_humidity +
       (25 - temperature) * HSENSOR_TEMPERATURE_COEFFICIENT);

  return ms8607_status_ok;
}

/**
 * \brief Returns the computed dew point
 *        Note : This function shall only be used when the heater is OFF. It
 * will return an error otherwise.
 *
 * \param[in] float - Actual temperature measured (degC)
 * \param[in] float - Actual relative humidity measured (%RH)
 * \param[out] float *- Dew point temperature (DegC).
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_heater_on_error : Cannot compute compensated humidity
 * because heater is on
 */
enum ms8607_status ms8607::get_dew_point(float temperature,
                                         float relative_humidity,
                                         float *dew_point) {
  double partial_pressure;

  if (hsensor_heater_on)
    return ms8607_status_heater_on_error;

  // Missing power of 10
  partial_pressure =
      pow(10, HSENSOR_CONSTANT_A -
                  HSENSOR_CONSTANT_B / (temperature + HSENSOR_CONSTANT_C));

  *dew_point =
      -HSENSOR_CONSTANT_B / (log10(relative_humidity * partial_pressure / 100) -
                             HSENSOR_CONSTANT_A) -
      HSENSOR_CONSTANT_C;

  return ms8607_status_ok;
}

/******************** Functions from Pressure sensor ********************/

/**
 * \brief Check whether MS8607 pressure sensor is connected
 *
 * \return bool : status of MS8607
 *       - true : Device is present
 *       - false : Device is not acknowledging I2C address
  */
bool ms8607::psensor_is_connected(void) {
  Wire.beginTransmission(PSENSOR_ADDR);
  return (Wire.endTransmission() == 0);
}

/**
 * \brief Reset the Pressure sensor part
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_i2c_transfer_error : Problem with i2c transfer
 *       - ms8607_status_no_i2c_acknowledge : I2C did not acknowledge
 */
enum ms8607_status ms8607::psensor_reset(void) {
  Wire.beginTransmission((uint8_t)PSENSOR_ADDR);
  Wire.write(PSENSOR_RESET_COMMAND);
  Wire.endTransmission();
  return ms8607_status_ok;
}

/**
 * \brief CRC check
 *
 * \param[in] uint16_t *: List of EEPROM coefficients
 * \param[in] uint8_t : crc to compare
 *
 * \return bool : TRUE if CRC is OK, FALSE if KO
 */
bool ms8607::psensor_crc_check(uint16_t *n_prom, uint8_t crc) {
  uint8_t cnt, n_bit;
  uint16_t n_rem, crc_read;

  n_rem = 0x00;
  crc_read = n_prom[0];
  n_prom[COEFFICIENT_NUMBERS] = 0;
  n_prom[0] = (0x0FFF & (n_prom[0])); // Clear the CRC byte

  for (cnt = 0; cnt < (COEFFICIENT_NUMBERS + 1) * 2; cnt++) {

    // Get next byte
    if (cnt % 2 == 1)
      n_rem ^= n_prom[cnt >> 1] & 0x00FF;
    else
      n_rem ^= n_prom[cnt >> 1] >> 8;

    for (n_bit = 8; n_bit > 0; n_bit--) {

      if (n_rem & 0x8000)
        n_rem = (n_rem << 1) ^ 0x3000;
      else
        n_rem <<= 1;
    }
  }
  n_rem >>= 12;
  n_prom[0] = crc_read;

  return (n_rem == crc);
}

/**
 * \brief Set pressure ADC resolution.
 *
 * \param[in] ms8607_pressure_resolution : Resolution requested
 *
 */
void ms8607::set_pressure_resolution(enum ms8607_pressure_resolution res) {
  psensor_resolution_osr = res;
}

/**
 * \brief Reads the psensor EEPROM coefficient stored at address provided.
 *
 * \param[in] uint8_t : Address of coefficient in EEPROM
 * \param[out] uint16_t* : Value read in EEPROM
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_i2c_transfer_error : Problem with i2c transfer
 *       - ms8607_status_no_i2c_acknowledge : I2C did not acknowledge
 *       - ms8607_status_crc_error : CRC check error on the coefficients
 */
enum ms8607_status ms8607::psensor_read_eeprom_coeff(uint8_t command,
                                                     uint16_t *coeff) {
  enum ms8607_status status = ms8607_status_ok;
  uint8_t i2c_status;
  uint8_t buffer[2];
  uint8_t i;

  /* Read data */
  Wire.beginTransmission((uint8_t)PSENSOR_ADDR);
  Wire.write(command);
  i2c_status = Wire.endTransmission();

  Wire.requestFrom((uint8_t)PSENSOR_ADDR, 2U);
  for (i = 0; i < 2; i++)
    buffer[i] = Wire.read();

  if (status != ms8607_status_ok)
    return status;

  if (i2c_status == i2c_status_err_overflow)
    return ms8607_status_no_i2c_acknowledge;
  if (i2c_status != i2c_status_ok)
    return ms8607_status_i2c_transfer_error;

  *coeff = (buffer[0] << 8) | buffer[1];

  if (*coeff == 0)
    return ms8607_status_i2c_transfer_error;

  return ms8607_status_ok;
}

/**
 * \brief Reads the ms8607 EEPROM coefficients to store them for computation.
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_i2c_transfer_error : Problem with i2c transfer
 *       - ms8607_status_no_i2c_acknowledge : I2C did not acknowledge
 *       - ms8607_status_crc_error : CRC check error on the coefficients
 */
enum ms8607_status ms8607::psensor_read_eeprom(void) {
  enum ms8607_status status;
  uint8_t i;

  for (i = 0; i < COEFFICIENT_NUMBERS; i++) {
    status = psensor_read_eeprom_coeff(PROM_ADDRESS_READ_ADDRESS_0 + i * 2,
                                       eeprom_coeff + i);
    if (status != ms8607_status_ok)
      return status;
  }

  if (!psensor_crc_check(eeprom_coeff,
                         (eeprom_coeff[CRC_INDEX] & 0xF000) >> 12))
    return ms8607_status_crc_error;

  psensor_coeff_read = true;

  return ms8607_status_ok;
}

/**
 * \brief Triggers conversion and read ADC value
 *
 * \param[in] uint8_t : Command used for conversion (will determine Temperature
 * vs Pressure and osr)
 * \param[out] uint32_t* : ADC value.
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_i2c_transfer_error : Problem with i2c transfer
 *       - ms8607_status_no_i2c_acknowledge : I2C did not acknowledge
 */
enum ms8607_status ms8607::psensor_conversion_and_read_adc(uint8_t cmd,
                                                           uint32_t *adc) {
  enum ms8607_status status = ms8607_status_ok;
  uint8_t i2c_status;
  uint8_t buffer[3];
  uint8_t i;

  /* Read data */
  Wire.beginTransmission((uint8_t)PSENSOR_ADDR);
  Wire.write(cmd);
  i2c_status = Wire.endTransmission();

  // 20ms wait for conversion
  vTaskDelay(pdMS_TO_TICKS(psensor_conversion_time[(cmd & PSENSOR_CONVERSION_OSR_MASK) / 2]));

  // Send the read command
  Wire.beginTransmission((uint8_t)PSENSOR_ADDR);
  Wire.write((uint8_t)PSENSOR_READ_ADC);
  i2c_status = Wire.endTransmission();

  Wire.requestFrom((uint8_t)PSENSOR_ADDR, 3U);
  for (i = 0; i < 3; i++)
    buffer[i] = Wire.read();

  if (status != ms8607_status_ok)
    return status;

  if (status != ms8607_status_ok)
    return status;

  if (i2c_status == i2c_status_err_overflow)
    return ms8607_status_no_i2c_acknowledge;
  if (i2c_status != i2c_status_ok)
    return ms8607_status_i2c_transfer_error;

  *adc = ((uint32_t)buffer[0] << 16) | ((uint32_t)buffer[1] << 8) | buffer[2];

  return status;
}

/**
 * \brief Compute temperature and pressure
 *
 * \param[out] float* : Celsius Degree temperature value
 * \param[out] float* : mbar pressure value
 *
 * \return ms8607_status : status of MS8607
 *       - ms8607_status_ok : I2C transfer completed successfully
 *       - ms8607_status_i2c_transfer_error : Problem with i2c transfer
 *       - ms8607_status_no_i2c_acknowledge : I2C did not acknowledge
 *       - ms8607_status_crc_error : CRC check error on the coefficients
 */
enum ms8607_status
ms8607::psensor_read_pressure_and_temperature(float *temperature,
                                              float *pressure) {
  enum ms8607_status status = ms8607_status_ok;
  uint32_t adc_temperature, adc_pressure;
  int32_t dT, TEMP;
  int64_t OFF, SENS, P, T2, OFF2, SENS2;
  uint8_t cmd;

  // If first time adc is requested, get EEPROM coefficients
  if (psensor_coeff_read == false)
    status = psensor_read_eeprom();
  if (status != ms8607_status_ok)
    return status;

  // First read temperature
  cmd = psensor_resolution_osr * 2;
  cmd |= PSENSOR_START_TEMPERATURE_ADC_CONVERSION;
  status = psensor_conversion_and_read_adc(cmd, &adc_temperature);
  if (status != ms8607_status_ok)
    return status;

  // Now read pressure
  cmd = psensor_resolution_osr * 2;
  cmd |= PSENSOR_START_PRESSURE_ADC_CONVERSION;
  status = psensor_conversion_and_read_adc(cmd, &adc_pressure);
  if (status != ms8607_status_ok)
    return status;

  if (adc_temperature == 0 || adc_pressure == 0)
    return ms8607_status_i2c_transfer_error;

  // Difference between actual and reference temperature = D2 - Tref
  dT = (int32_t)adc_temperature -
       ((int32_t)eeprom_coeff[REFERENCE_TEMPERATURE_INDEX] << 8);

  // Actual temperature = 2000 + dT * TEMPSENS
  TEMP = 2000 + ((int64_t)dT *
                     (int64_t)eeprom_coeff[TEMP_COEFF_OF_TEMPERATURE_INDEX] >>
                 23);

  // Second order temperature compensation
  if (TEMP < 2000) {
    T2 = (3 * ((int64_t)dT * (int64_t)dT)) >> 33;
    OFF2 = 61 * ((int64_t)TEMP - 2000) * ((int64_t)TEMP - 2000) / 16;
    SENS2 = 29 * ((int64_t)TEMP - 2000) * ((int64_t)TEMP - 2000) / 16;

    if (TEMP < -1500) {
      OFF2 += 17 * ((int64_t)TEMP + 1500) * ((int64_t)TEMP + 1500);
      SENS2 += 9 * ((int64_t)TEMP + 1500) * ((int64_t)TEMP + 1500);
    }
  } else {
    T2 = (5 * ((int64_t)dT * (int64_t)dT)) >> 38;
    OFF2 = 0;
    SENS2 = 0;
  }

  // OFF = OFF_T1 + TCO * dT
  OFF = ((int64_t)(eeprom_coeff[PRESSURE_OFFSET_INDEX]) << 17) +
        (((int64_t)(eeprom_coeff[TEMP_COEFF_OF_PRESSURE_OFFSET_INDEX]) * dT) >>
         6);
  OFF -= OFF2;

  // Sensitivity at actual temperature = SENS_T1 + TCS * dT
  SENS =
      ((int64_t)eeprom_coeff[PRESSURE_SENSITIVITY_INDEX] << 16) +
      (((int64_t)eeprom_coeff[TEMP_COEFF_OF_PRESSURE_SENSITIVITY_INDEX] * dT) >>
       7);
  SENS -= SENS2;

  // Temperature compensated pressure = D1 * SENS - OFF
  P = (((adc_pressure * SENS) >> 21) - OFF) >> 15;

  *temperature = ((float)TEMP - T2) / 100;
  *pressure = (float)P / 100;

  return status;
}

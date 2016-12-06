#!/system/bin/sh

#  ****************************************************************************
function ToolsLoadModule
{
	typeset INSMOD
	echo "--- Load module ---"
	INSMOD=$(insmod fpc1020.ko)
	lsmod
}

#  ****************************************************************************
function ToolsUnloadModule
{
	typeset RMMOD
	echo "--- Unload module ---"
	RMMOD=$(rmmod fpc1020)
	lsmod
}

#  ****************************************************************************
function ToolsSelftest
{
	typeset SELFTEST

	echo "--- Selftest ---"
	SELFTEST=$(cat ${fpc_spi_path}/diag/selftest)

	if [[ "$SELFTEST" == "1" ]]; then
		echo "Selftest PASS"
	else
		echo "Selftest FAIL"
	fi
}

#  ****************************************************************************
function ToolsReadRegister
{
	typeset SET_REG
	typeset SET_DATA

	typeset GET_REG
	typeset GET_SIZE
	typeset GET_DATA

	echo "--- SPI debug, read register ---"
	echo "Register id? : "
	read reg_id

	SET_REG=$(echo $reg_id > ${fpc_spi_path}/diag/spi_register)

	if [[ $? -eq 0 ]]; then
		GET_REG=$(cat ${fpc_spi_path}/diag/spi_register)
		GET_SIZE=$(cat ${fpc_spi_path}/diag/spi_regsize)
		GET_DATA=$(cat ${fpc_spi_path}/diag/spi_data)

		echo "Register $GET_REG ($GET_SIZE bytes), value = $GET_DATA"
	else
		echo "Error: invalid register"
	fi
}


#  ****************************************************************************


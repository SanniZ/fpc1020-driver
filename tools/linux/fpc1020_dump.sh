#!/system/bin/sh

#  ****************************************************************************
function DumpChipId
{
	typeset VERSION_TEXT

	echo "--- Dump chip id ---"
	VERSION_TEXT=$(cat ${fpc_spi_path}/diag/chip_id)
	echo chip_id=$VERSION_TEXT
}

#  ****************************************************************************
function DumpSettings
{
	typeset GET_R1
	typeset GET_R2
	typeset GET_C1
	typeset GET_C2

	echo "--- Dump capture settings ---"
	GET_R1=$(cat ${fpc_spi_path}/setup/capture_row_start)
	GET_R2=$(cat ${fpc_spi_path}/setup/capture_row_count)
	GET_C1=$(cat ${fpc_spi_path}/setup/capture_col_start)
	GET_C2=$(cat ${fpc_spi_path}/setup/capture_col_groups)
	echo capture_row_start=$GET_R1, capture_row_count=$GET_R2
	echo capture_col_start=$GET_C1, capture_col_groups=$GET_C2
}

#  ****************************************************************************
function DumpSettingsADC
{
	typeset SET_MUX
	typeset GET_GAIN
	typeset GET_SHIFT
	typeset GET_PXL_CTRL

	echo "--- Dump ADC settings ---"

	select=0

	until [ $select -ge $fpc_multi_capture ]; do
		SET_MUX=$(echo $select > ${fpc_spi_path}/setup/capture_settings_mux)
		GET_MUX=$(cat ${fpc_spi_path}/setup/capture_settings_mux)
		GET_GAIN=$(cat ${fpc_spi_path}/setup/adc_gain)
		GET_SHIFT=$(cat ${fpc_spi_path}/setup/adc_shift)
		GET_PXL_CTRL=$(cat ${fpc_spi_path}/setup/pxl_ctrl)
		echo mux=$GET_MUX adc_gain=$GET_GAIN adc_shift=$GET_SHIFT pxl_ctrl=$GET_PXL_CTRL

    		select=$((select + 1))
	done
}


#  ****************************************************************************


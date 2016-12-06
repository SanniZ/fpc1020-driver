#!/system/bin/sh

#  ****************************************************************************
function ImageFetch
{
	image_file=$(date "+image_%y-%m-%d_%H%M%S.raw")
	dd bs=1024 if=${fpc_sensor_device} of=${fpc_image_dir}/${image_file}

	echo "Image fetched: ${fpc_image_dir}/${image_file}"
}


#  ****************************************************************************
function ImageWaitCapture
{
	echo "--- Wait and Capture (place finger on sensor) ---"
	echo 1 > ${fpc_spi_path}/setup/capture_mode
	echo 1 > ${fpc_spi_path}/setup/capture_count

	ImageFetch
}

#  ****************************************************************************
function ImageCapture
{
	echo "--- Capture single (place finger on sensor and press ENTER) ---"
	read ENTER
	echo 2 > ${fpc_spi_path}/setup/capture_mode
	echo 1 > ${fpc_spi_path}/setup/capture_count

	ImageFetch
}

#  ****************************************************************************
function ImageCaptureMulti
{
	echo "--- Capture single (place finger on sensor and press ENTER) ---"
	read ENTER
	echo 2 > ${fpc_spi_path}/setup/capture_mode
	echo $fpc_multi_capture > ${fpc_spi_path}/setup/capture_count

	ImageFetch
}

#  ****************************************************************************
function ImageCheckerboard
{
	echo "--- Checkerboard ---"
	echo 3 > ${fpc_spi_path}/setup/capture_mode
	dd bs=1024 if=${fpc_sensor_device} of=${fpc_image_dir}/checkerboard.raw
}

#  ****************************************************************************
function ImageCheckerboardInverted
{
	echo "--- Checkerboard (inverted) ---"
	echo 4 > ${fpc_spi_path}/setup/capture_mode
	dd bs=1024 if=${fpc_sensor_device} of=${fpc_image_dir}/checkerboard_inv.raw
}

#  ****************************************************************************


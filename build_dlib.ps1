function BuildForWindows($platform, $build_type) {
    $build_dir = "build"
    mkdir $build_dir -Force -ErrorAction Stop | Out-Null
    cd $build_dir
    pwd

    if ($platform -eq "x64") {
        $msbuild_platform = "x64"
    }
    else {
        $msbuild_platform = "Win32"
    }



    cmake -G "Visual Studio 16 2019" `
        -A $msbuild_platform `
        -D CMAKE_BUILD_TYPE=${build_type} `
        -D CMAKE_INSTALL_PREFIX=install `
        -D DLIB_NO_GUI_SUPPORT=OFF `
        -D DLIB_USE_BLAS=ON `
        -D DLIB_GIF_SUPPORT=ON `
        -D DLIB_PNG_SUPPORT=ON `
        -D DLIB_JPEG_SUPPORT=ON `
        -D DLIB_USE_CUDA=OFF ../dlib

    msbuild INSTALL.vcxproj /t:build /p:configuration=$build_type /p:platform=$msbuild_platform -maxcpucount
    ls
    cd ..
}
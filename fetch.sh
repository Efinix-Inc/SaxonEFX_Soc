#!/bin/sh
dir=$RISCV_DEVHOME
cp -rf bsp/efinix/EfxRubySoc $dir/soc_Ruby/soc_Ruby_sw/bsp/efinix/
cp -rf bsp/efinix/EfxJadeSoc $dir/soc_Jade/soc_Jade_sw/bsp/efinix/
cp -rf bsp/efinix/EfxOpalSoc $dir/soc_Opal/soc_Opal_sw/bsp/efinix/
cp -rf bsp/efinix/EfxOpalSoc_t8 $dir/soc_Opal_t8/soc_Opal_sw_t8/bsp/efinix/

cp hardware/netlist/RubySoc* $dir/soc_Ruby/soc_Ruby_hw/source/
cp $dir/soc_Ruby/soc_Ruby_hw/source/*.bin $dir/soc_Ruby/soc_Ruby_hw/T120F324_devkit/

cp hardware/netlist/JadeSoc* $dir/soc_Jade/soc_Jade_hw/source/
cp $dir/soc_Jade/soc_Jade_hw/source/*.bin $dir/soc_Jade/soc_Jade_hw/T20F256_devkit/

cp hardware/netlist/OpalSoc.v* $dir/soc_Opal/soc_Opal_hw/source/
cp $dir/soc_Opal/soc_Opal_hw/source/*.bin $dir/soc_Opal/soc_Opal_hw/T20F256_devkit/

cp hardware/netlist/OpalSoc_t8.v* $dir/soc_Opal_t8/soc_Opal_hw_t8/source/
cp $dir/soc_Opal_t8/soc_Opal_hw_t8/source/*.bin $dir/soc_Opal_t8/soc_Opal_hw_t8/T8F81_devkit/

echo "source fetching done"


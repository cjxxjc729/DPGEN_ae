# DPGEN_ae
The modified DPGEN workflow of atomic swap MC simulation in HEA

# Description

This project uses a modified DPGEN workflow to simulate the element distribution of high entropy materials. We use MC simulation combined with an active learning scheme based on machine learning potential to selectively tag atomic energy and gradually improve the force field. Finally, we use the obtained force field to train a larger model.

![fig4_test](https://github.com/cjxxjc729/DPGEN_ae/assets/42018996/5c8ca971-e2aa-4e37-b490-c861c3a3f41c)

# Installation

运行本项目前, 先运行
source ~/scripts/env.sh

后使用next_iter.sh, 建立新的iter, 进入后依次进入01, 02, 03三个文件夹, 分别运行./train.sh, ./exploration.sh ./labelling.sh 执行

./train.sh 结束后可运行validate_ae_dft_dp.sh来验证dft和dp的关系

# testing_programme
正在开发中



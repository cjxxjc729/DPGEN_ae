# DPGEN_ae
The modified DPGEN workflow of atomic swap MC simulation in HEA

# Description

This project uses a modified DPGEN workflow to simulate the element distribution of high entropy materials. We use MC simulation combined with an active learning scheme based on machine learning potential to selectively tag atomic energy and gradually improve the force field. Finally, we use the obtained force field to train a larger model.

![fig4_test](https://github.com/cjxxjc729/DPGEN_ae/assets/42018996/5c8ca971-e2aa-4e37-b490-c861c3a3f41c)

# Installation

Before running this project, run
source ~/scripts/env.sh

Then use next_iter.sh, create a new iter, enter the folder 01, 02, 03, run. /train.sh, . /exploration.sh . /labelling.sh Execute

# testing_programme
Under development



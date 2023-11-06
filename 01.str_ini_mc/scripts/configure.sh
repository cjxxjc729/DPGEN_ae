#!/bin/bash

ae_script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"



echo "#!/bin/bash
#export PATH=${ae_script_dir}:\$PATH
export script_dir_global=${ae_script_dir}" > ${ae_script_dir}/env.sh



SHELL=/bin/bash
devops_state = main
working_dir = `pwd`

install: local_build_and_deploy

reinstall : create_env && install

rebuild: 
	pip uninstall mlflowops -y \
	&& poetry build  \
	&& pip install .

local_build_and_deploy: 
	pip uninstall mlflowops -y \
	&& python setup.py install \
	&& mlflowops

package_build:
	python -m build

package_list:
	unzip -l dist/*.whl  

create_env:
	conda deactivate -n mlflowops \
	&& conda env remove -n mlflowops -y \
	&& conda create -n mlflowops python=3.10 -y \
	&& conda activate mlflowops

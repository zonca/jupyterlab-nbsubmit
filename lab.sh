rm nohup.out
nohup jupyter lab --port 22222 --no-browser --debug --NotebookApp.nbserver_extensions="{'jupyterlab-slurm':True}" &

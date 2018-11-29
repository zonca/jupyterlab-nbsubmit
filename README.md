# jupyterlab-nbsubmit

A JupyterLab extension to submit Jupyter Notebooks for remote execution on a Slurm based Supercomputer.

This Jupyterlab extension is based on [jupyterlab-slurm](https://github.com/NERSC/jupyterlab-slurm)

## Necessary configuration

* You need to thave the [`nbsubmit`](https://github.com/zonca/nbsubmit) installed and configured (see its documentation)
* You need to have SLURM commands available locally on the machine you are using, for this you can also create fake commands that forward the command via SSH, for example `/usr/local/bin/squeue`:

        #!/bin/sh
        ssh comet "squeue $@"

## Example usage

See https://github.com/zonca/jupyterlab-nbsubmit/issues/1

## Prerequisites for Installation

* JupyterLab
* NodeJS

## Prerequisites for running

* JupyterLab
* NodeJS
* Slurm

Note that if you are using JupyterLabHub, currently (v0.1.0) the locations of the:

- hub server
- single-user JupyterLab servers
- Slurm installation

all have to be the same as each other for this extension to work. [We are looking for a fix for this.](https://github.com/jupyterhub/jupyterlab-hub/issues/70) Suggestions are welcome.

## (Development) Installation

### Notebook server extension (permanent)
To install the notebook server extension, do the following in the repository directory:

```bash
pip install .
jupyter serverextension enable --py jupyterlab-slurm --sys-prefix
```

Ostensibly it should be sufficient to do the following to uninstall the server extension:

```bash
jupyter serverextension disable jupyterlab-slurm
pip uninstall jupyterlab-slurm
```

However, it has seemed necessary at times to uninstall and then reinstall Jupyter altogether (with conda `conda uninstall jupyter_core`), since `serverextension disable` does not seem to delete or remove the extension. Thus, even after sourcing a newer version of the server extension, doing `serverextension enable` would just re-enable the old version (rather than installing the newer version). (Plus having the output of `jupyter serverextension list` cluttered by no longer existing extensions is unpleasant.)

### Notebook server extension (temporary)
A less permanent way to enable the notebook extension during development would be to add the following flag when starting JupyterLab:

```bash
--NotebookApp.nbserver_extensions="{'jupyterlab-slurm':True}"
```

### JupyterLab extension
To install the "JupyterLab extension" (i.e. the TypeScript/Javascript part), do the following in the repository directory (requires NodeJS v. 4.0 or higher):

```bash
npm install
npm run build
jupyter labextension install .
```

To reload after updating or changing the Javascript part of the extension, it is necessary to do the following:

```bash
npm run build
jupyter lab build
```

(This assumes you haven't added any npm dependencies to `package.json`; if you have, then it is necessary to run `npm install` before `npm run build`.)

To uninstall the Javascript part of the extension entirely, it suffices to do

```bash
jupyter labextension uninstall jupyterlab-slurm
```

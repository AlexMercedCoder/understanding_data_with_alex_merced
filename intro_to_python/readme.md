## Create a Virtual Environment and Run Jupyterlab

- Must have Python and Anaconda Installed

### With Anaconda

**Create Environment**

initialize conda if isn't already

```bash
### For Bash
conda init bash
### For zsh
conda init zsh
```

create an environment
```
conda create -n myenv python=3.11
```

activate the environment
```
conda activate myenv
```

To later deactivate an environment
```
conda deactivate
```

** Run Notebook **

install dependencies
```bash
conda install jupyter jupyterlab
```

run jupyter lab
```bash
jupyter lab
```

### With Pip

create an environment
```bash
python -m venv venv
```

activate environment
```bash
source ./venv/bin/activate
```

install jupyter and jupyterlab
```bash
pip install jupyter jupyterlab
```

run jupyterlab
```
jupyter lab
```
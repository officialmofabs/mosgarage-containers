# Machine Learning Project Template

Machine learning projects can be extraordinarily complex involving data collection, preprocessing, model training, model evaluation, as well as visualization and reporting. Often, the starting point for many is to use Jupyter Notebooks, which are excellent for trying out new ideas and exploring data, but fall short as the project becomes larger as often this results in long, labyrinthine files.

This repo is an example machine learning project file structure that runs fully and attempt to avoid repetition in code while keeping individual files relatively short. This template/demo is based on the [Cookiecutter Data Science project](https://drivendata.github.io/cookiecutter-data-science/), which is a fantastic project, and deviates in a few ways that seem appropriate for machine learning projects specifically.

Let's start by introducing the recommended file structure, then discuss each piece and why it's included. Below, files are shown first and folders after denoted with a `/` appended such as `folder/`.

## Recommended file structure
```
├── README.md          <- The top-level README for developers using this project
├── Makefile           <- Makefile with commands like `make data` or `make train`
├── config.yml         <- Configuration file
├── requirements.txt   <- The requirements file for reproducing the environment
├── .gitignore         <- Git ignore file
├── LICENSE
├── data/
│   ├── raw/           <- The original, immutable data dump
│   ├── interim/       <- Intermediate data that has been transformed
│   └── processed/     <- The final, canonical data sets for modeling
│
├── docs/              <- Any descriptors of your data or models
│
├── models/            <- Trained models (so you don't have to rerun them)
│
├── notebooks/         <- Jupyter notebooks for temporary EDA, exploration, etc.
│
├── reports/           <- Generated analysis as HTML, PDF, LaTeX, etc.
│   └── figures/       <- Generated graphics and figures to be used in reporting
│
├── results/           <- Saved model outputs and/or metrics
│
└── src/               <- Source code for use in this project
    ├── __init__.py    <- Makes src a Python module
    │
    ├── data/          <- Scripts to download or generate data
    │   └── make_dataset.py
    │
    ├── preprocess/    <- Scripts to turn raw data into features for modeling
    │   └── build_features.py
    │
    ├── model/         <- Scripts to train models and apply models  
    │   ├── predict_model.py
    │   └── train_model.py
    │
    ├── evaluate/      <- Scripts to validate and apply the model to data  
    │
    ├── visualization/ <- Scripts to create exploratory and results oriented visualizations
    │   └── visualize.py
    │
    └── common/        <- Scripts shared among other modules
```

## `READEME.md`

A readme file should be you guide to your project for others that may use it (for reproducibility sake) as well as for your future self after you've stepped away from the project for 6 months, and return having forgotten most of what you've done. At minimum, this [markdown](https://github.com/lifeparticle/Markdown-Cheatsheet) document should describe:
- What the project does
- Why the project is useful (for tools) or what you learned (for analysis projects)
- How users can get started with the project
- For research, a link to any papers or further documentation

## `makefile`

A makefile is an interactive table of contents for your project. The premise of the makefile is to be able to type simple commands that are essentially shortcuts for writing out longer command line expressions for running bits of software. You can list out the different processes that are part of your project and run them with simple commands like `make download`, `make preprocess`, `make train`, etc. These simply become shorthand for the code running the scripts themselves. For example `make run_a_file` could be set to run `python file.py`.  To learn more check out this [makefile tutorial](https://makefiletutorial.com/) (for c programming, but is extensive and has relevant content) and this more [Python-specific tutorial](https://www.sas.upenn.edu/~jesusfv/Chapter_HPC_6_Make.pdf).

This is another example of a component of this template that ensures that your future self thanks you for making it easier to navigate the complexity of processes in your machine learning project.

In the makefile in this example, you'll notice that the `python -m` execution is used which executes by module name calling executing the code following the `if __name__ == "__main__"` conditional at the bottom of the corresponding module. This allows us to execute local packages that contain relative imports without the need to actually install the package. More on the use of the `-m` flag can be found in this [Stack Overflow thread](https://stackoverflow.com/questions/7610001/what-is-the-purpose-of-the-m-switch).

> [!NOTE]
> For Windows users, Make is more challenging to install. I recommend using Chocolately; you can [use this guide here](https://earthly.dev/blog/makefiles-on-windows/).

## `config.yaml`

The config file is your map to where your data live and any parameters for your model. As you move from one computer to another the names of data files could change, the directory structures for your data may change, and the config file is the map for your code that you update before running the program to keep up with any changes. In the example, the config file contains the link from which the data can be downloaded, the directories to store the raw, interim, and processed data, as well as where the various models, metrics, and visualizations from the project should be saved. You can also include key parameters for your code that you would otherwise need to input on the command line. Your config file should be updated any time you move between systems.

In this template, the file format chosen is a YAML file \([brief tutorial here](https://www.cloudbees.com/blog/yaml-tutorial-everything-you-need-get-started)\). You can then easily [read from the config file in python](https://python.land/data-processing/python-yaml) to use the contents of this file anywhere in your program removing the need for any hard coded references to files, directories, or parameters you may want to adjust.

## `requirements.txt`

For any project to be reproducible, you'll need to provide a list of all the dependencies of the project. In the `requirements.txt` file you can list each dependency and use `conda` or `pip` to install them. It's recommended that you create a new environment for each project that you work on to ensure compatibility. Additionally, if any of your code is version-specific (meaning it requires version 1.25.7 or perhaps anything after or before some version), set the version as well by specifying the version after an equal sign, such as `numpy=1.25.0`. Note this creates a `requirements.txt` file that is compatible with conda/mamba but differs from the version used when installing with `pip` (that requires a double equal sign `==`).

Also, be sure to limit the constraints to just those required for your code to run to ensure dependencies can be successfully installed on other systems without conflicts (this is especially true across platforms). To create the environment from the requirements.txt file, you can use the command `conda create --name ENV_NAME --file requirements.txt`. To use `pip` you can similarly use the command `pip install -r requirements. txt`.

## `.gitignore`

There are some files you may not want to be posted to public repositories that may include temporary files (e.g. everything that appears in `__pycache__`, those annoying `.DS_Store` files that have a habit of appearing on a Mac when you open a folder in finder) and private files (files that hold API keys or personal information). For all of these, you can use `.gitignore` files to prevent them from being uploaded to a repo. Learn more about [how to construct those files here](https://www.atlassian.com/git/tutorials/saving-changes/gitignore) and you can find a [template Python `.gitignore` file to customize here](https://github.com/github/gitignore/blob/main/Python.gitignore).

## `LICENSE`

While not necessary for the operation of the code, it's recommended to add license if you're placing your code on a public repository like Github. There are many options and one common choice is the MIT License, which is used here. There are [many licenses](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository) that you can choose from, although [open licenses](https://choosealicense.com/licenses/) are great for the wider community if it's appropriate for your work.

## `data/`

Place all your data in one place (if the data are small enough to fit into a folder; if not, I'd recommend adjusting the config file to point to some form of external storage). Three folders can be helpful here: `raw` for the original, immutable data that will never change; `interim` for intermediate data products or transformations that occur during preprocessing; and `processed` which contains the final, training/testing ready data.

## `docs/`

This folder is a place to store any documentation about your data or models for reference. Perhaps there's a data dictionary - store it here. Perhaps you're using a model that is somewhat novel, perhaps you include the paper on the specifications of the model here. Keep any documents you may need to fully understand your data and processing tools.

## `models/`

This folder contains saved models, especially models that have been trained. By saving the models to file, you don't have to retrain the model each time you need to use it, saving computation.

## `notebooks/`

Notebooks are great for exploring data and creating certain visualizations. Place all the notebooks in one place and name them descriptively so that they don't clutter the file structure.

## `reports/`

Data visualizations and reports that depend on them can go in this folder. Having a `figures/` subfolder can be particularly convenient so that you have a single folder to draw from for any reports. You can even create reports that directly ingest those figures so that they automatically update when you update the files.

## `results/`

Once you've taken your trained model (or models) and applied them either to a validation dataset or to an unseen test set, `results/` is a folder to store files that have any predictions or metrics resulting from that so that you don't have to rerun those validation and prediction processes each time you wish to analyze or visualize them.

## `src/` - the heart of the project

This is the heart of the project - the source code. All code that's used should be organized within this folder and `__init__.py` files (even if they're blank) be added to each folder and subfolder so that all the code can be accessed as a package. One possible configuration of these folders would be:

- `common/'. This is a folder where I recommend keeping tools that may be common across multiple functions. For example, tools to read from the config file, tools to save or load variables from the current workspace to file for future use. This is meant to support the 'don't repeat yourself' (DRY) principle of programming.
- `data/`. Files associated with data downloading or access should be stored here and through these files the `/data/raw/` folder should be populated.
- `evaluate/'. This folder stores the code to evaluate the model - apply the model to validation data and calculate any relevant metrics and save those to file.
- `model/'. All code for the underlying model, the training and prediction processes, are stored here.
- `preprocess/'. Code for splitting the data into training, validation, and/or testing sets; data cleaning; data scaling; and feature engineering should live here.
- `visualization/'. Code for any visualizations of the data, performance metrics, or other aspects of the modeling process go here.

## Environment Management

You'll likely want to create a virtual environment with the entries in requirements.txt. Creating a separate environment for each project that will require unique dependencies will likely save you time and frustration. This can be done with a Python virtual environment or a Conda environment. I use [Mamba](https://mamba.readthedocs.io/en/latest/) for installing packages since it's far faster than Conda and can be used as a direct drop-in for Conda. Mamba can be downloaded [here](https://github.com/conda-forge/miniforge#mambaforge).

Note: if you accidentally generate an environment that you didn't want, you can remove it using the command `conda remove --name ENV_NAME --all` where `ENV_NAME` is replaced with your environment name.

## Adjust as needed

Templates are made to be guides and typically won't fit every project perfectly. I would assume this would require some adaptation in most cases and others are likely to see better ways of doing what was attempted here (feel free to submit an issue share suggestions for improvement, of course!)
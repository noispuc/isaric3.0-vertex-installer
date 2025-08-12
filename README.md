# 📦 ISARIC HUB SA – VERTEX Installer

## 🧠 Overview

- Directory structure  
- PowerShell script to install **pyenv** & **Python 3.12.6** with VERTEX dependencies  
- PowerShell script to verify installation (VERTEX, Python, pyenv, dependencies)  
- VERTEX user license  
- Inno Setup script for the installer  
- File indicating VERTEX version  
- Final installer executable  

## 📦 Project Structure

- `src/`: Main code files 
  - `output/`: Installer executable  
- `tests/`: Automatic PowerShell test scripts  
- `docs/`: Project documentation  

## 📚 Documentation

All docs were written manually (no third-party tools).  
You can access them via the [ISARIC website]() or in the `docs/` folder.

## ⚙️ Requirements

- Windows 11  
- PowerShell ≥ 5.1 (ExecutionPolicy: RemoteSigned or Bypass)  
- Administrator privileges  

## 🚀 Usage

1. Download and unzip the release.  
2. Run `output\VERTEX_Setup.exe`.

> You don’t need to clone the repository—only the executable is necessary.  
> For a full walkthrough, see the guide on the [ISARIC website]().


# ⚙️ Post-Installation

## How does VERTEX work?

### What is VERTEX

VERTEX is a data analysis tool for medical datasets.
It retrieves data primarily from REDCap via API, requiring an internet connection.
It can also process local CSV and other formats (not covered in this README).

### Data Processing

- Data retrieved from REDCap is processed into Insight Panels.
- Each Insight Panel generates visual outputs (images) displayed in your browser.
- Processing is handled by two libraries: IsaricAnalytics and IsaricDraw.

### Inicializing VERTEX

The installer will automatically install a shortcut file named `VERTEX` in your desktop.
By double clicking it the application VERTEX will run and will automatically open into your browser, however if this doesnt happen please access the following url:

- *[http://127.0.0.1:8050](http://127.0.0.1:8050)*

### VERTEX Projects

Now, it is important for you to know that VERTEX runs projects, it will automatically come with the following projects as default:

- `ARChetypeCRF_dengue_synthetic`
- `ARChetypeCRF_h5nx_synthetic`
- `ARChetypeCRF_h5nx_synthetic_mf`
- `ARChetypeCRF_mpox_synthetic`
- `Examples_Tutorial`

Each projects contains, necessarily, a config file and a folder containing the insight panels for that project.
The file structure for a project is as follows:

`Examples_Tutorial`
|
|-> config_file.json
|-> insight_panels
    |
    |-> Examples_Generic.py
    |-> RiskFactors_InHospitalMortality.py

When you run a project for the first time, VERTEX creates a folder named PUBLIC.
This is an aggregated version of VERTEX that does not use your raw REDCap data.
Instead, it uses the results from each Insight Panel to reproduce outputs without exposing your dataset, only the aggregated results.
This is particularly useful for publishing sensitive data safely.

#### config_file.json

The config_file.json is where the first step of configuring your project begins.
The JSON structure is as follows:

```
{
	"api_url": "YOUR API URL",
	"api_key": "YOUR API KEY",
	"project_name": "Examples",
	"map_layout_center_lat": 6,
	"map_layout_center_lon": -75,
	"map_layout_zoom": 1.7,
	"save_public_outputs": true,
	"public_outputs_filepath": "PUBLIC/",
	"insight_panel_filepath": "insight_panels/",
	"insight_panels": [
	]
}
```

The only fields you need to modify are api_url and api_key.
Both can be found in your REDCap project. To learn how to locate your api_url and api_key in REDCap, see the tutorial on the [ISARIC website]().

Once you have obtained your api_url and api_key, replace the placeholder values in the config_file.json with your own.

#### Insight Panel

This is where the core logic of VERTEX is implemented.
An Insight Panel is the component responsible for processing your data and generating visual outputs.

Each Insight Panel follows the format below:

```
import numpy as np
import pandas as pd
import IsaricDraw as idw
import IsaricAnalytics as ia


def define_button():
    '''Defines the button in the main dashboard menu'''
    # Insight panels are grouped together by the button_item. Multiple insight
    # panels can share the same button_item are grouped in the dashboard menu
    # according to this
    # However, the combination of button_item and button_label must be unique
    button_item = 'Examples'
    button_label = 'Generic Panel'
    output = {'item': button_item, 'label': button_label}
    return output


def create_visuals(
        df_map, df_forms_dict, dictionary, quality_report,
        filepath, suffix, save_inputs):
    '''
    Create all visuals in the insight panel from the RAP dataframe
    '''

    # CODE #

    return ()
```

Imports
All Insight Panels must import NumPy and Pandas, since the dataset is processed using Pandas DataFrames and additional NumPy functionalities. Other imports can be included as needed.

define_button()
This function defines how your Insight Panel appears in the VERTEX dashboard menu (located in the lower-left corner of the screen).

- button_item → Groups your Insight Panel into a menu section.

- button_label → Defines the label shown on the button.

create_visuals(...)
This is the main data-processing function. Here, you will use IsaricAnalytics and IsaricDraw to perform the analysis and create visual outputs.

⚠️ The function must return an IsaricDraw object. Standard tables or arrays will not work.

For a visual walkthrough, see the [ISARIC website]().
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
You can access them via the ISARIC website (link) or in the `docs/` folder.

## ⚙️ Requirements

- Windows 11  
- PowerShell ≥ 5.1 (ExecutionPolicy: RemoteSigned or Bypass)  
- Administrator privileges  

## 🚀 Usage

1. Download and unzip the release.  
2. Run `output\VERTEX_Setup.exe`.

> You don’t need to clone the repository—only the executable is necessary.  
> For a full walkthrough, see the guide on the ISARIC website (link).


## ⚙️ Post-Installation

## How does VERTEX work?

### What is VERTEX

VERTEX is a data analysing tool for medical dataset.

### Data Entry

VERTEX uses REDCap to retrieve data for the analysis. It needs internet to operate as it uses REDCap api from the user's project to retrieve the data needed to be processed. 
VERTEX is also capable to analyse data from CSV's and other local media, however this is not covered in this README.

### Data Processing

As said the Data Enty section, VERTEX uses REDCap to retrieve data, this data will be processed in such called **Insight Panels** which will output a images and those images will be loaded into your screen. Two libraries are reponsible for this, IsaricAnalytics and IsaricDraw.

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

After running VERTEX with a desired project for the first time, a folder called PUBLIC will be created. This is a agregated version of vertex which doesnt use your data from REDCap, it actually uses the results from each insight panel to regenerate to output without exposing your dataset, only the results. This is extremely helpful to publish sensible data.

#### config_file.json

#### Insight Panel
  

# Spectram

Toolbox for MATLAB(R) and GNU Octave for the analysis of dynamic spectroscopic data by SVD-based MLS. Spectram allows to deconvolute the data into transition models and their associated spectral components, which can be directly interpreted. Spectram can be applied to any desired spectroscopic technique and the applied models can be chosen individually.
A more detailed description on how spectram works can be found in the associated meta paper published in the Journal of Open Research Software under the [DOI:10.5334/jors.323](https://doi.org/10.5334/jors.323).

## Getting Started

### Prerequisites

MATLAB(R) 9.0 with Optimization Toolbox\
or\
GNU Octave 4.4.1 with Optim package

### Installation

Download or clone the repository. Add the destination folder to you MATLAB search path or Octave load path. For instance by:

```
addpath(folderName)
```

#### GNU Octave
In GNU Octave the optim package needs to be installed. The optim package itself requires the packages struct, statistics and io. For a list of installed packages type:

```
pkg list
```

When not found in the list, the optim package and its dependencies can be installed by:

```
pkg install -forge io struct statistics optim
```

Open [typical_example.m](typical_example.m) for a short introduction on the usage and capabilities of Spectram.

## Citation

Please cite the meta paper, if you found Spectram useful for your work: 
Rabe, M., 2020. Spectram: A MATLAB® and GNU Octave Toolbox for Transition Model Guided Deconvolution of Dynamic Spectroscopic Data. *Journal of Open Research Software*, 8(1), p.13. DOI: http://doi.org/10.5334/jors.323  

You may also use the Bibtex citation:
```
@Article{Rabe_Spectram2020,
  author  = {Martin Rabe},
  title   = {{S}pectram: A {MATLAB}® and {GNU} {O}ctave {T}oolbox for {T}ransition {M}odel {G}uided {D}econvolution of {D}ynamic {S}pectroscopic {D}ata},
  journal = {Journal of Open Research Software},
  year    = {2020},
  volume  = {8},
  number  = {1},
  pages   = {13},
  month   = jun,
  doi     = {10.5334/jors.323},
  url     = {http://doi.org/10.5334/jors.323},
}

```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

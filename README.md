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

Open 'typical_example.m' for a short introduction on the usage and capabilities of Spectram.

## Author

Martin Rabe

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

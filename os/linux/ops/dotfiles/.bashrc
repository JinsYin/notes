# Anaconda
export PATH=~/anaconda3/bin:$PATH
alias condaenv='source activate'   # e.g. condaenv python2.7
alias condaexit='conda deactivate' # e.g. condaexit python2.7

# Golang
export GOPATH=~/go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin

# Openshift
eval $(minishift oc-env)
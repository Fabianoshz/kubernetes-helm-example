#!/bin/bash

# This scripts is inteded to be used as a post-render for helm.
# Given that we have a kustomization.yaml file on the extra-yamls
# folder we are going to run kustomize to apply the rules before
# the apply on the cluster but after the render of the resources.

if [ -f "extra-yamls/kustomization.yaml" ]; then
    cat <&0 > extra-yamls/base.yaml

    kubectl kustomize ./extra-yamls
    rm ./extra-yamls/base.yaml
else
    cat <&0
fi

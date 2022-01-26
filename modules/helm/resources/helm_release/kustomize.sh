#!/bin/bash

if [ -f "extra-yamls/kustomization.yaml" ]; then
    cat <&0 > extra-yamls/base.yaml

    kubectl kustomize ./extra-yamls
    rm ./extra-yamls/base.yaml
else
    cat <&0
fi

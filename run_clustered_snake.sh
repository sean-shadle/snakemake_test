#!/usr/bin/env bash

snakemake --cluster-config cluster.yaml --jobs 3 --cluster "sbatch -M {cluster.cluster} -A {cluster.account} -p {cluster.partition} -C {cluster.constraint}" --latency-wait 50

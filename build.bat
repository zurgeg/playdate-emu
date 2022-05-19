@echo off
rd play8.pdx /s /q
pdc . play8.pdx
PlaydateSimulator play8.pdx
rem leftovers from running the sim
rd .sentry-native /s /q
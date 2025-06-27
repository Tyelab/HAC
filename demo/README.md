## Running Demo

The matlab script "main_demo.m" contains all instructions to running our demo example.
The two data files, shared as .mat files, contain trial averaged responses to either ensure stimulus (reward) or airpuff stimulus (punishment).
The neurons are ordered in both such that they correspond across the two datasets.  The 6 second time window for each dataset consists of 2 seconds of baseline prior to the onset of the tone (conditioned-stimulus or CS).  The unconditioned stimulus (US) is either an Ensure reward or a mildly punishing airpuff to the face and is delivered around 1-1.5 sec after tone onset.

The demo walks the user through:
1. how to normalize the data,
2. how to cluster the data,
3. how to make plots of the average response to each cluster

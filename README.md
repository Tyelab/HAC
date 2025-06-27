# HAC
Hierarchical Clustering is a visualization technique used widely in neuroscience to group together similar neural responses to stimuli.  

## System requirements
To run this code, you must have MATLAB installed, and have the Statistics and Machine Learning Toolbox. 
This code was tested using MATLAB version 9.14.0.2286388 (R2023a) Update 3 and the Statistics and Machine Learning Toolbox version: '12.5'.

## Demo
In our example data, we have provided a set of neural responses to reward and punishment stimuli.  We will concatenate the two responses so that each row of the resulting matrix represents a single neuron; and contains the trial-averaged reponse to reward over time and trial averaged response to punishment over time.  After clustering, the neural responses are grouped into specific response profiles (e.g., excited to reward and inihbited to punishment), which can be viewed further with the averaged response plots for each cluster.


## Running Demo

The matlab script "main_demo.m" contains all instructions to running our demo example.

# Data
The two data files, shared as .mat files, contain trial averaged responses to either ensure stimulus (reward) or airpuff stimulus (punishment).
The neurons are ordered in both such that they correspond across the two datasets.  The 6 second time window for each dataset consists of 2 seconds of baseline prior to the onset of the tone (conditioned-stimulus or CS).  The unconditioned stimulus (US) is either an Ensure reward or a mildly punishing airpuff to the face and is delivered around 1-1.5 sec after tone onset.

# Steps
The demo walks the user through:
1. how to normalize the data,
2. how to cluster the data,
3. how to make plots of the average response to each cluster

# Run the demo
1. open matlab
2. cd to the demo folder
3. type main_demo into the matlab command window.

# Understanding the output
Running the main_demo function will produce two plots.  The first plot (Figure 1) shows the raw input data, after reward and punishment responses have each been zscored to the baseline window prior to the CS-tone onset and then concatenated.  The neuronal unit numbers start along the Y-axis with the number 1 at the top of the screen and 241 at the bottom of the y-axis.  

The second plot (Figure 2) shows the results of clustering the responses.  On the left side of the plot is the dendrogram and shows the cluster number on the left side of that plot.  The specific parameters are shown in the title of the plot.  To turn this off, select the plot with your pointer and in the matlab command window type `title('')`.  The right side shows the heatmap, or the trial-averaged neural response to each simulus.  The x-axis here shows the times, where the CS-onset is shown at 0 s.

Hover your mouse over the left plot again and select the magnifing tool to zoom in on cluster 7 results.  You can now read the y-labels more clearly.  These labels identify which neurons from your starting set ended up in this cluster.  You should see neuron indices 2, 9, 58, 177, and 190 are included in this cluster.  You can zoom in on your original data (figure 1) as a sanity check.  


#Spider

Spider is a library that implements several Artificial Neural Networks (ANNs) and lets you run simulations on the networks.

If you are looking for a library to use in serious development, please take a look at [ruby-fann](http://ruby-fann.rubyforge.org/).

If you are looking to learn more about ANNs, keep reading.


##Overview

There are currently two types of ANNs implemented:

* [HebbNet](http://en.wikipedia.org/wiki/Hebbian_theory)
* [Perceptron](http://en.wikipedia.org/wiki/Perceptron)

The **HebbNet** is a [feedforward](http://en.wikipedia.org/wiki/Feedforward_neural_network) single-layer network which utilizes the Hebb Rule for the learning algorithm. It is mostly here for learning purposes, as it is one of the simplest networks that can be implemented, and is limited in the problems it can solve.

The **Perceptron** is also a feedforward neural network, which can be single-layer or multilayer. So far, only the single-layer version is implemented. This network can solve any problem in which the data set is [linearly separable](http://en.wikipedia.org/wiki/Linearly_separable); in other words, if you were to draw in a graph the set of positive answers and the set of negative answers, you should be able to separate them with a straight line.

##Introduction

We shall model the logical AND as a starting point, using the single-layer Perceptron.

    #X   Y   R
    #1   1   1
    #1   0   0
    #0   1   0
    #0   0   0

This is the standard representation of the AND behavior. In order to feed this information to a neural network, we will replace the 0s for -1s, converting it from binary to bipolar representation. This allows the network to converge to a solution faster, as well as return 0 for answers it is undecided on.

    training_data = 
      [[ 1,  1,  1],
       [ 1, -1, -1],
       [-1,  1, -1],
       [-1, -1, -1]]

Next, we must decide the learning rate and the threshold. The learning rate dictates how strongly the network will readjust itself when it encounters an error, while the threshold (in this case) stands for how wide the "undecided" response area will be.

    net = Spider::Perceptron.new(2, :learning_rate => 1, :treshold => 0)
    net.train(training_data)

The network is now ready to respond to inputs. This isn't very exciting though, because we gave all the possible input-output combinations to the net, and so it will clearly be right.

    net.run([1,1])
    #=> 1
    net.run([-1,-1])
    #=> -1

But wait! Don't leave yet! We mentioned that we selected bipolar input because it allowed us to leave inputs as unknown values. Let's try that.

    net.run([1,0])
    #=> 0
    net.run([-1,0])
    #=> -1
    net.run([0,0])
    #=> -1

If one input is 1 and the other unknown, the network is unable to decide. That is the correct answer, as the chance is 50/50 at that point. If one input is -1, it defaults to -1, which is also the correct answer --- regardless of the other input, the answer should be -1. If both inputs are unknown, it defaults to -1, as in 3 out of 4 outcomes the answer will be -1.

Kinda neat, huh?

##Pattern Recognition

Logical gates aren't much fun, so let's try something else.

Networks treat inputs as nothing but vectors of numbers. The value that you give to those numbers is what gives meaning and lets you know how to interpret the results. As long as one can map the desired characteristics to -1s, 0s and 1s, one can model a problem for the network to solve.

Let's solve the problem of recognizing a 'C', in a 5x5 area.

    # =====
    # =
    # =
    # =
    # =====

    # =====
    # =   =
    # =
    # =   =
    # =====

    #  ===
    # =   =
    # =
    # =   =
    #  ===

Those are 3 different ways to represent a 'C' in our limited space. Let's convert this to bipolar inputs for the network.

    training_data = []

    training_data <<
      [ 1,  1,  1,  1,  1,
        1, -1, -1, -1, -1,
        1, -1, -1, -1, -1,
        1, -1, -1, -1, -1,
        1,  1,  1,  1,  1, 1] #last 1 is the expected result!
    
    training_data <<
      [ 1,  1,  1,  1,  1,
        1, -1, -1, -1,  1,
        1, -1, -1, -1, -1,
        1, -1, -1, -1,  1,
        1,  1,  1,  1,  1, 1]
    
    training_data <<
      [-1,  1,  1,  1, -1,
        1, -1, -1, -1,  1,
        1, -1, -1, -1, -1,
        1, -1, -1, -1,  1,
       -1,  1,  1,  1, -1, 1]

Now, let's train the network on this data.

    net = Spider::Perceptron.new(25, :learning_rate => 0.5, :treshold => 5)

The rest is left to the reader as an exercise.

* How much can one alter the 'C' pattern before it starts returning 0 or -1?
* How much missing data can the network withstand?
* Try repeating the previous two experiments with 0 as the treshold. How do the answers change?

##Further Reading

An excellent starting book on the subject is,

Fundamentals of Neural Networks - Architectures, Algorithms and Applications, by Laurene Fausett.

The cliffs notes version of ANNs can be found on [wikipedia](http://en.wikipedia.org/wiki/Artificial_neural_network).
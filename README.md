# NeuralNet

## Description
  This project is a minimalist yet powerful implementation of a feedforward neural network built entirely from scratch in C++, leveraging the Eigen library for fast and intuitive matrix operations. It covers the fundamental mechanisms of neural networks including forward propagation, backpropagation, and gradient descent — without using any external machine learning frameworks.

The goal is educational: to demystify how neural networks operate under the hood by building every component manually — from layer definitions to the training loop. The network is trained on the MNIST dataset, showcasing how core deep learning principles translate into working code with just matrices and math.

## Prerequisites

- **C++ Compiler**: Ensure you have a modern C++ compiler that supports **C++20** (required for certain functionalities such as `ntohl` for endianess conversion).
- **Eigen Library**: This project uses the Eigen library for matrix operations. [Download Eigen](https://eigen.tuxfamily.org/dox/GettingStarted.html) if it's not already installed on your system.

### Configuration
  The project expects Eigen to be located at `D:/Coding/Softwares/eigen-3.4.0`. If Eigen is installed in a different directory on your system, you need to update the `Makefile` accordingly:

1. Open the `Makefile`.
2. Locate the line that sets the `CXXFLAGS` variable:
    ```makefile
    CXXFLAGS = -I D:/Coding/Softwares/eigen-3.4.0
    ```
3. Update the path to match the location where Eigen is installed on your system. For example, if Eigen is installed in `/usr/local/include/eigen3`, you should modify the line to:
    ```makefile
    CXXFLAGS = -I /usr/local/include/eigen-3.4.0
    ```

## Build Instructions

1. **Clone the repository**:
    ```bash
    git clone https://github.com/TPrimetheOG/NeuralNet.git
    cd NeuralNet
    ```

2. **Update the Eigen path** in the `Makefile` if necessary.

3. **Build the project** using `make`:
    ```bash
    make
    ```

4. **Run the executable**:
    ```bash
    ./main
    ```

## Dataset

The MNIST dataset can be downloaded from [Yann LeCun's data set on Kaggle](https://www.kaggle.com/datasets/hojjatk/mnist-dataset). You will need the following files:

- **Training images**: `train-images-idx3-ubyte`
- **Training labels**: `train-labels-idx1-ubyte`
- **Test images**: `t10k-images-idx3-ubyte`
- **Test labels**: `t10k-labels-idx1-ubyte`

After downloading, place these files in the `data/MNIST/raw/` directory of your project.
Make sure to rename the files from `.idx3-ubyte` to `-idx3-ubyte` when extracting the dataset from Kaggle.

## Example Usage

Here’s a basic example demonstrating how to use the neural network:

```cpp
#include <iostream>
#include <Eigen/Dense>

#include "layer.h"
#include "functions.h"
#include "neural_network.h"
#include "utils.h"

using namespace Eigen;
using namespace functions;

// File paths to the MNIST dataset
const std::string mnist_train_data_path = "data/MNIST/raw/train-images-idx3-ubyte";
const std::string mnist_train_label_path = "data/MNIST/raw/train-labels-idx1-ubyte";
const std::string mnist_test_data_path = "data/MNIST/raw/t10k-images-idx3-ubyte";
const std::string mnist_test_label_path = "data/MNIST/raw/t10k-labels-idx1-ubyte";

int main() {
    srand(time(0));

    // Prepare datasets
    std::vector<VectorXd> train_dataset;
    std::vector<VectorXd> label_train_dataset;
    std::vector<VectorXd> test_dataset;
    std::vector<VectorXd> label_test_dataset;

    // Read MNIST data
    utils::read_mnist_train_data(mnist_train_data_path, train_dataset);
    utils::read_mnist_train_label(mnist_train_label_path, label_train_dataset);
    utils::read_mnist_test_data(mnist_test_data_path, test_dataset);
    utils::read_mnist_test_label(mnist_test_label_path, label_test_dataset);

    // Create the neural network with 2 layers: one hidden layer and one output layer
    Layer hidden_layer(784, 64, sigmoid, sigmoid_derivative);
    Layer output_layer(64, 10, sigmoid, sigmoid_derivative);
    NeuralNetwork nn({hidden_layer, output_layer});

    // Train the network on the training dataset
    nn.train(train_dataset, label_train_dataset, 0.1, 3);

    // Test the network on the test dataset
    nn.test(test_dataset, label_test_dataset);

    return 0;
}

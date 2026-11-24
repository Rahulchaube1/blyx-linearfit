# Train a factored matrix

One training row holds a target and two dense feature vectors. A prediction is xᵀWz. Starting at zero, each gradient update adds a scalar multiple of that row’s outer product to W. LinearFit stores the left and right features, their product Gram matrix and one coefficient per row. It performs the same ordered squared-error SGD in that basis. Individual weights and held-out predictions are available without materializing W.

The largest fixture contained four dense feature pairs and represented a 2,097,152 × 1,048,576 matrix. The 48 SGD updates reduced half mean squared error from 0.234375 to 1.40 × 10⁻⁸. Across all 35 coordinates of a separate random matrix the largest discrepancy against an explicitly updated matrix was 2.78 × 10⁻¹⁷.

[Native commands and compiler installation](https://github.com/Rahulchaube1/blyx-linearfit/blob/v0.2.0/SCALE.md)

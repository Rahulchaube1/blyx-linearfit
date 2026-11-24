# Bilinear regression on paired features

One training row holds a target and two dense feature vectors. A prediction is xᵀWz. Starting at zero, each gradient update adds a scalar multiple of that row’s outer product to W. LinearFit stores the left and right features, their product Gram matrix and one coefficient per row. It performs the same ordered squared-error SGD in that basis. Individual weights and held-out predictions are available without materializing W.

## Try the native command

Extract the archive for your platform from the [LinearFit 0.2.0 release](https://github.com/Rahulchaube1/blyx-linearfit/releases/tag/v0.2.0). Add its directory to PATH or use the executable’s full path. Run the fixture commands from the extracted directory.

~~~sh
linearfit pair-fit fixtures/pairs.txt 12 0.1 > coefficients.csv
linearfit pair-weight fixtures/pairs.txt coefficients.csv 0 1
linearfit pair-predict fixtures/pairs.txt coefficients.csv 1,0 0,1
pair-study factors 21
~~~

## Scope and input contract

Training uses O(n²) Gram storage for n examples and O(n(d+e)) feature storage for widths d and e. The fitted matrix has rank at most n. To resume, keep the factors and row order identical. Coefficient files contain one comma-separated line of doubles. This method applies to separable feature pairs and a linear prediction rule.

## Import in Blyx

The executable includes its runtime. To compile the source example, install the tested compiler revision and a host linker, then run these commands from the tagged source tree.

~~~sh
cargo install --locked --git https://github.com/Rahulchaube1/blyxxxx --rev 120d6b6ec6df09ff018d7c18752fb3297b5e629d blyxc
blyxc native-run scale_example.blyx
~~~

~~~blyx
use bilinear;

fn main() {
    let left = [1,0,0,1];
    let right = [1,0,0,1];
    let gram = lf_pair_gram(left,right,2);
    let alpha = lf_pair_fit(gram,[1,-1],[0,0],1,1.0);
    println!(lf_pair_predict(left,right,alpha,[2,3],[1,1]));
    println!(lf_pair_weight(left,right,alpha,1,1));
}
~~~

## Verification

The largest fixture contained four dense feature pairs and represented a 2,097,152 × 1,048,576 matrix. The 48 SGD updates reduced half mean squared error from 0.234375 to 1.40 × 10⁻⁸. Across all 35 coordinates of a separate random matrix the largest discrepancy against an explicitly updated matrix was 2.78 × 10⁻¹⁷. [Study, raw timings and reproduction instructions](https://www.blyx-lang.space/articles/training-in-factors)

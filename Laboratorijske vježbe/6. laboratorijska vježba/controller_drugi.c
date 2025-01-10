#include "controller.h"

// Define constants for the number of coefficients for demominator and nominator polynomials
#define M 3
#define N 3

float controller(float u)
{
    // Coefficients of the denominator polynomial (poles)
    const float a[N] = {0.951219512195122, -1.951219512195122, 1};
   
    // Coefficients of the numerator polynomial (zeros)
    const float b[M] = {0.758841463414634, -1.579878048780488, 0.822256097560976};

    // Static variables to store past outputs and inputs of the controllerz
    static float y[N]; // y[k], y[k-1]
    static float u1[M]; // u[k], u[k-1]

     // Shift the past input values u(k-1), u(k-2), ..., u(k-m)
    for (int i = M - 1; i > 0; i--)
    {
        u1[i] = u1[i - 1];
    }

    // Update the past input value u(k-1) with the current input u(k)
    u1[0] = u;
    // Calculate the current output y(k) based on the given input u(k) and past values
    y[0] = 0; // Initialize the current output y(k) to zero


    // Update the current output y(k) using the zeros (numerator)
    for (int i = 0; i < M; i++)
    {
        y[0] += b[i] * u1[i];
    }

    // Update the current output y(k) using the poles (denominator)
    for (int i = 1; i < N; i++)
    {
        y[0] -= a[i] * y[i];
    }

    // Shift the past output values y(k-1), y(k-2), ..., y(k-n)
    for (int i = N - 1; i > 0; i--)
    {
        y[i] = y[i - 1];
    }

    // Return the current output of the controller y(k)
    return y[0];
}
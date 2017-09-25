#include <iostream>
#include <cmath>
#include <ctime>

using namespace std;

double Diff(double(*f)(double), double);
void ValidCheck(double);

double func1(double);
double func2(double);
double func3(double);
double func4(double);
double func5(double);

double Bisection(double(*f)(double), double, double, int);
double Newton(double(*f)(double), double, int);
double Secant(double(*f)(double), double, double, int);
double RFM(double(*f)(double), double, double, int);

void main() {

	double start = clock();

	//double sol = Bisection(func5, 0.3, 10, 0);
	//double sol = Newton(func5, 0.3, 0);
	//double sol = Secant(func5, 0.3, 10, 0);
	double sol = RFM(func5, 0.3, 10, 0);

	double end = clock();

	cout << "Answer : " << sol << endl;
	cout << "Time : " << (double)(end-start)/CLOCKS_PER_SEC << endl;
}

double Bisection(double(*f)(double), double a, double b, int iter) {
	/* Bisection method
	*	f = function
	*	a = first_x
	*	b = second x
	*	iter = number of iteration
	*/

	if (iter == 0 && f(a)*f(b) > 0) {
		cout << "Invalid input error" << endl;
		exit(1);
	}

	double new_x = (a + b) / 2;
	if (f(new_x) == 0 || abs(new_x - a) < 0.0001){
		cout << "Iteration : " << iter << endl;
		return new_x;
	}
	else if (f(a)*f(new_x) < 0)
		return Bisection(f, new_x, a, iter+=1);
	else
		return Bisection(f, new_x, b, iter+=1);
}

double Newton(double(*f)(double), double x, int iter) {
	/* Newton method
	*	f = function
	*	x = first_x
	*	iter = number of iteration
	*/
	double new_x = x - f(x) / Diff(f, x);
	
	if (f(new_x) == 0 || abs(x - new_x) < 0.0001) {
		cout << "Iteration : " << iter << endl;
		return new_x;
	}
	else
		return Newton(f, new_x, iter+=1);
}

double Secant(double(*f)(double), double x1, double x0, int iter) {
	/* Secant method
	*	f = function
	*	x1 = recent_x
	*	x0 = prev_x
	*	iter = number of iteration
	*/
	double new_x = x1 - (f(x1) / ((f(x1) - f(x0)) / (x1 - x0)));
	
	if (f(new_x) == 0 || abs(x1 - new_x) < 0.0001) {
		cout << "Iteration : " << iter << endl;
		return new_x;
	}
	else
		return Secant(f, new_x, x1, iter+=1);
}

double RFM(double(*f)(double), double a, double b, int iter) {
	/* Regula Falsi method
	*	f = function
	*	a = recent_x
	*	b = prev_x
	*	iter = number of iteration
	*/

	if (iter == 0 && f(a)*f(b) > 0) {
		cout << "Invalid input error" << endl;
		exit(1);
	}
	double new_x = a - (f(a) / ((f(a) - f(b)) / (a - b)));
	if (f(new_x) == 0 || abs(a - new_x) < 0.0001) {
		cout << "Iteration : " << iter << endl;
		return new_x;
	}
	else if (f(a)*f(new_x) < 0)
		return RFM(f, new_x, a, iter+=1);
	else
		return RFM(f, new_x, b, iter+=1);
}

// Differentiation function
double Diff(double(*f)(double), double x) {
	double eps = 0.0000001;
	return (f(x + eps) - f(x)) / eps;
}

void ValidCheck(double x) {
	if (isnan(x)) {
		cout << "Invalid number error!!" << endl;
		exit(1);
	}
	return;
}

double func1(double x) {
	double f = log(x) + sin(x);
	ValidCheck(f);
	return f;
}

double func2(double x) {
	double f = pow(x, 2) + 3 * x + 1;
	ValidCheck(f);
	return f;
}

double func3(double x) {
	double f = pow(x, 5) + 2 * pow(x, 3) + exp(pow(x, 2) + x);
	ValidCheck(f);
	return f;
}

double func4(double x) {
	double f = cos(pow(x, 2) + x);
	ValidCheck(f);
	return f;
}

double func5(double x) {
	double f = pow(x, 3) + log(pow(x, 3)) + 1;
	ValidCheck(f);
	return f;
}
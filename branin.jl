using Surrogates
using Plots
default()

function branin(x)
    x1 = x[1]
    x2 = x[2]
    b = 5.1 / (4*pi^2);
    c = 5/pi;
    r = 6;
    a = 1;
    s = 10;
    t = 1 / (8*pi);
    term1 = a * (x2 - b*x1^2 + c*x1 - r)^2;
    term2 = s*(1-t)*cos(x1);
    y = term1 + term2 + s;
end

n_samples = 80
lower_bound = [-5, 0]
upper_bound = [10,15]
xys = sample(n_samples, lower_bound, upper_bound, SobolSample())
zs = branin.(xys);
x, y = -5.00:10.00, 0.00:15.00
p1 = surface(x, y, (x1,x2) -> branin((x1,x2)))
xs = [xy[1] for xy in xys]
ys = [xy[2] for xy in xys]
scatter!(xs, ys, zs)
p2 = contour(x, y, (x1,x2) -> branin((x1,x2)))
scatter!(xs, ys)
plot(p1, p2, title="True function")

# radial_surrogate = RadialBasis(xys, zs, lower_bound, upper_bound)


function improved_branin(x, time_step)
    x1 = x[1]
    x2 = x[2]
    b = 5.1 / (4*pi^2);
    c = 5/pi;
    r = 6;
    a = 1;
    s = 10;
    t = 1 / (8*pi);
    # Adding noise  to the function's output
    noise = randn() * time_step # Simulating time varying noise
    term1 = a * (x2 - b*x1^2 + c*x1 - r)^2
    term2 = s*(1-t)* cos(x1 + noise) # Introducung the dyanamic component
    y  = term1 + term2 + s
end
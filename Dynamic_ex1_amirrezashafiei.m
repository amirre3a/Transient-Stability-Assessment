%% constants
k_values = [1, 0];
x_values = [0.2, 0.4];
vs = 1;  

%% range of values for vmin
vmin_values = linspace(0, 0.995, 100);  %V_min range as needed (0 to 0.995)

%% Initialize an array to store pdmax values and corresponding k and x values
num_combinations = length(k_values) * length(x_values);
data = struct('k', cell(1, num_combinations), 'x', cell(1, num_combinations), 'pdmax_values', cell(1, num_combinations));

%% Calculation of pdmax values using the equation for different k and x values
idx = 1;
figure; 
for k = k_values
    for x = x_values
        pdmax_values = zeros(size(vmin_values));
        for i = 1:length(vmin_values)
            vmin = vmin_values(i);
            expression_inside_sqrt = (k^2 + 1) * vs^2 - vmin^2;
            if expression_inside_sqrt >= 0
                pdmax_values(i) = ((-k * vmin^2) + vmin * sqrt(expression_inside_sqrt)) / (x * (k^2 + 1));
            else
                pdmax_values(i) = NaN;  % Handle negative values
            end
            % Ensure pdmax is within the desired range (0 to 2.5)
            pdmax_values(i) = max(0, min(2.5, pdmax_values(i)));
        end
        
        data(idx).k = k;
        data(idx).x = x;
        data(idx).pdmax_values = pdmax_values;
        
%% subplot for each combination
        subplot(num_combinations, 1, idx);
        plot(vmin_values, pdmax_values);
        xlabel('vmin');
        ylabel('pdmax');
        title(['Graph of pdmax vs. vmin for k = ' num2str(k) ', x = ' num2str(x)]);
        grid on;
        
        idx = idx + 1;
    end
end

%% Display
disp('Conclusion: This table shows the pdmax values for different combinations of k and x.');



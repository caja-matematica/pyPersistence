function n = persdia(varargin)
% n = number of persistence intervals
% inputs: mandatory filename = name of file containing 
% birth and death info in column form, and a number plot-type.
% if plot type = 0, we plot ALL intervals, otherwise only the
% ones that actually die.

if nargin==0
    retutn -1;
else
    filename = varargin{1};
end    

plot_type = 0;
if nargin == 2 
    plot_type = varargin{2};
end


% extract birth and death indices
ints = load(filename);
births = ints(:,1);
deaths = ints(:,2);

% extract maximum death time encountered:
maxd = max(deaths);
if (maxd < 0) 
    maxd = max(births)+1;
end

% extract indices of those intervals which die
normal_ints = find(deaths ~= -1);

figure;

% we always plot these:
plot(births(normal_ints),deaths(normal_ints),'b.');
hold on;
axis([0,maxd+2,0,maxd+2]);

% plot the diagonal
diag = 0:(maxd+1)/20:maxd+1;
plot(diag,diag,'g-');

title(filename);
xlabel('birth');
ylabel('death');

% extract indices of those intervals which persist throughout
if plot_type == 0 
  inf_ints = find(deaths == -1);
  infd_vec = (maxd + 1)*ones(size(inf_ints));
  plot((births(inf_ints)), infd_vec , 'rd');
end
    
n = size(births);
hold off;
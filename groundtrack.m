function gt = groundtrack(lat, lon,type,titleinfo)
    % Ground track generator. Input lattitude and longitude values in
    % degrees. Currently two types are supported. 'simple' type, plots
    % groundmap over solid coloured land, lakes and rivers. 'fancy' type,
    % plots groundmap over a terrain textured world map. Add the title
    % label to add to the figures.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Script Author: Ali Nawaz, Delft University of Technology.
    % Aerospace Engineering Faculty [LR]
    % Mechanical, Maritime and Materials Engineering Faculty [3ME]
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if strcmp(type,'simple')== 1 
        landareas = shaperead('landareas.shp','UseGeoCoords',true); % import landareas
        figure;
        load geoid; % load geoid shape
        axesm eckert4; % load Eckert4 projection coordinates
        framem; gridm; % show frame and grid
        axis on
        hold on
        ax = worldmap('World'); % plot world map
        land = shaperead('landareas', 'UseGeoCoords', true);
        geoshow(ax, land, 'FaceColor', [0.5 0.7 0.5]); % show lands
        lakes = shaperead('worldlakes', 'UseGeoCoords', true);
        geoshow(lakes, 'FaceColor', 'blue'); % show lakes
        rivers = shaperead('worldrivers', 'UseGeoCoords', true);
        geoshow(rivers, 'Color', 'blue'); % show rivers
        geoshow(lat,lon,'LineWidth', 2, 'color', 'r'); % show ground track
        title(titleinfo);
        hold off
    elseif strcmp(type,'fancy')== 1
        figure;
        hold on
        delta = lat; % store latitude of ground track
        alpha = lon; % store longitude of ground track
        load coast; % load coastlines
        load topo; % load topography information
        axesm eckert4; % load Eckert4 projection coordinates
        framem; gridm; % turn on grids and frames
        axis on; % show axis
        ax = worldmap('World'); % Show world map
        land = shaperead('landareas', 'UseGeoCoords', true); 
        geoshow(ax, land, 'FaceAlpha', [0]);% Show coordinates 
        geoshow(topo,topolegend,'Displaytype','texturemap') % show rough topography
        demcmap(topo) % add colormap appropriate to terrain elevation data, note it doesn't show the ice sheets! 
        geoshow(lat,long,'Color','k'); % add borders to coastline
        geoshow(delta,alpha,'LineWidth', 2, 'color', 'r'); % show the ground track
        title(titleinfo);
        hold off
    end
end

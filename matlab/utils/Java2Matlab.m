function [ M ] = Java2Matlab( J )
% Convert Java collections to matlab matrices

switch class(J)
    
    case 'java.lang.Float'
        M = J.floatValue;
        
    case 'java.lang.String'
        M = J.toCharArray';
        
    case 'double'
        M = J;
        
    case 'logical'
         M = J;
         
    case 'java.lang.Long'
        M = J.intValue;
        
    case 'java.util.ArrayList'
        M = [];
        for i=1:J.size()
            M = [M Java2Matlab(J.get(i-1))];
        end
       
    case 'java.util.HashSet'
        M = [];
        it = J.iterator;
        while it.hasNext()
            M = [M Java2Matlab(it.next())];
        end
        
    case 'java.util.HashMap'
        entries = J.entrySet.toArray;
        M = containers.Map('KeyType','double','ValueType','any');
        for i=1:numel(entries)
            M(entries(i).getKey) = Java2Matlab(entries(i).getValue);
        end
        
    case 'api.info.Profile1DInfo'
        M = struct( ...
            'start_time',Java2Matlab(J.getStart_time),...
            'dt',Java2Matlab(J.getDt),...
            'values',Java2Matlab(J.getValues));
        
    case 'api.info.NetworkInfo'
        M = struct( ...
            'nodes',Java2Matlab(J.getNodes),...
            'links',Java2Matlab(J.getLinks) ) 
        
    case 'api.info.CommodityInfo'
        M = struct(...
            'id',Java2Matlab(J.getId) , ...
            'name',Java2Matlab(J.getName) , ...
            'subnetwork_ids',Java2Matlab(J.getSubnetwork_ids) , ...
            'pathfull',Java2Matlab(J.isPathfull));
        
    case 'api.info.SubnetworkInfo'
        M = struct( ...
            'id',J.getId , ...
            'is_path',J.isPath,...
            'link_ids',Java2Matlab(J.get_link_ids));
        
    case 'api.info.ControllerInfo'
        M = struct( ...
            'id',Java2Matlab(J.getId) , ...
            'type',Java2Matlab(J.getType.toString()),...
            'act_ids',Java2Matlab(J.getActuators_ids),...
            'dt',Java2Matlab(J.getDt),...
            'sig_info',Java2Matlab(J.getPretimed_signal_info()) );
        
    case 'api.info.ActuatorInfo'
        M = struct( ...
            'id',Java2Matlab(J.getId) , ...
            'type',Java2Matlab(J.getType.toString()) );
                
    case 'api.info.SplitInfo'
        error('not implemented')
        
    case 'api.info.DemandInfo'
        M = struct( ...
            'type',Java2Matlab(J.getType),...
            'link_id',Java2Matlab(J.getLink_id),...
            'path_id',Java2Matlab(J.getPath_id),...
            'commodity_id',Java2Matlab(J.getCommodity_id),...
            'profile',Java2Matlab(J.getProfile));

    case 'api.info.MacroLaneGroupInfo'
        error('not implemented')
        
    case 'api.info.PointInfo'
        M = struct( ...
            'x',Java2Matlab(J.getX),...
            'y',Java2Matlab(J.getY));
        
    case 'api.info.LaneGroupInfo'
        M = struct( ...
            'id',Java2Matlab(J.getId),...
            'length',Java2Matlab(J.getLength),...
            'max_vehicles',Java2Matlab(J.getMax_vehicles),...
            'lanes',Java2Matlab(J.getLanes),...
            'actuator_id',Java2Matlab(J.getActuator_id));
            
    case 'api.info.RoadGeomInfo'
        error('not implemented')
        
    case 'api.info.LinkInfo'
        M = struct( ...
            'id', Java2Matlab(J.getId) , ...
            'full_length', Java2Matlab(J.getFull_length) , ...
            'full_lanes', Java2Matlab(J.getFull_lanes) , ...
            'start_node_id', Java2Matlab(J.getStart_node_id) , ...
            'end_node_id', Java2Matlab(J.getEnd_node_id) , ...
            'is_source', Java2Matlab(J.isIs_source) , ...
            'is_sink', Java2Matlab(J.isIs_sink) , ...
            'road_geom', Java2Matlab(J.getRoad_geom) , ...
            'shape', Java2Matlab(J.getShape) , ...
            'lanegroups', Java2Matlab(J.getLanegroups) , ...
            'ffspeed_kph', Java2Matlab(J.get_ffspeed_kph) , ...
            'jam_density_vpkpl', Java2Matlab(J.get_capacity_vphpl) , ...
            'capacity_vphpl', Java2Matlab(J.get_jam_density_vpkpl) );
       
    case 'api.info.NodeInfo'
        M = Java2Matlab(J.getId());
        
    case 'api.info.ScenarioInfo'
        M = struct( ...
            'network', Java2Matlab(J.getNetwork) , ...
            'commodities', Java2Matlab(J.getCommodities) , ...
            'subnetworks', Java2Matlab(J.getSubnetworks) , ...
            'controllers', Java2Matlab(J.getControllers) , ...
            'actuators', Java2Matlab(J.getActuators) , ...
            'splits', Java2Matlab(J.getSplits) , ...
            'demands', Java2Matlab(J.getDemands) );

    case 'api.info.ModelInfo'
        M = struct( ...
            'link_ids',Java2Matlab(J.getLink_ids) , ...
            'name',Java2Matlab(J.getName) , ...
            'dt',Java2Matlab(J.getDt) );
        
        
    otherwise
        error(['unsupported class ' class(J)])
        
end

## TODO

 foreman start -f Procfile -p 3000

.col-md-1
  %i.glyphicon.glyphicon-plus{style: "height: 50px; margin-top: 50px;", "ng-click" => "loadTrips(car)"}
.col-md-4
.col-md-8{"ng-if" => "car.trips"}
  %table.table
    %thead
      %tr
        %th Start
        %th End
        %th 
          Distance
          %a{"ng-click" => "whatDistanceUnit()"} ({{ distanceUnit }})
        %th
    %tbody
      %tr{"ng-repeat" => "trip in car.trips"}
        %td {{ trip.started_at | date:'medium' }}
        %td {{ trip.ended_at | date:'medium' }}
        %td {{ tripLength(trip.distance_m) | number : 2 }}{{ distanceUnit }}
        %td
          %span{"ng-if" => "trip.path"}
            %button.btn.btn-default{"ng-click" => "viewMap(trip)"} View Map
            %mapbox{"map-id" => "{{ mapBoxAccessToken }}", lat: "{{ trip.start_location.lat }}", lng: "{{ trip.start_location.lon }}", zoom: 10, "ng-if" => "trip", width: 200, height: 200}
              %feature-layer{data: "{{ trip.geoLine }}"}
              %marker{lat: "{{ trip.start_location.lat }}", lng: "{{ trip.start_location.lon }}", color: "#39cccc", icon: "car"}
                {{ trip.start_location.tag | humanize }}
              %marker{lat: "{{ trip.end_location.lat }}", lng: "{{ trip.end_location.lon }}", color: "#BBBBBB", icon: "cross"}
                {{ trip.end_location.tag | humanize }}
          %span{"ng-if" => "!trip.path"} No Path Recorded



http://angular-ui.github.io/angular-google-maps/#!/
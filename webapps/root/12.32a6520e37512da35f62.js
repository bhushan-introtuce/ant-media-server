(window.webpackJsonp=window.webpackJsonp||[]).push([[12],{O51e:function(e,t,n){"use strict";n.r(t),n.d(t,"CalendarModule",(function(){return o}));var a=n("tyNb"),l=n("ofXK"),r=n("3Pt+"),i=n("fXoL"),c=[{path:"",children:[{path:"",component:function(){function e(){}return e.prototype.ngOnInit=function(){var e=$("#fullCalendar"),t=new Date,n=t.getFullYear(),a=t.getMonth(),l=t.getDate();e.fullCalendar({viewRender:function(e,t){"month"!=e.name&&$(".fc-scroller").perfectScrollbar()},header:{left:"title",center:"month,agendaWeek,agendaDay",right:"prev,next,today"},defaultDate:t,selectable:!0,selectHelper:!0,views:{month:{titleFormat:"MMMM YYYY"},week:{titleFormat:" MMMM D YYYY"},day:{titleFormat:"D MMM, YYYY"}},select:function(t,n){swal({title:"Create an Event",html:'<div class="form-group"><input class="form-control" placeholder="Event Title" id="input-field"></div>',showCancelButton:!0,confirmButtonClass:"btn btn-success",cancelButtonClass:"btn btn-danger",buttonsStyling:!1}).then((function(a){var l=$("#input-field").val();l&&e.fullCalendar("renderEvent",{title:l,start:t,end:n},!0),e.fullCalendar("unselect")}))},editable:!0,eventLimit:!0,events:[{title:"All Day Event",start:new Date(n,a,1),className:"event-default"},{id:999,title:"Repeating Event",start:new Date(n,a,l-4,6,0),allDay:!1,className:"event-rose"},{id:999,title:"Repeating Event",start:new Date(n,a,l+3,6,0),allDay:!1,className:"event-rose"},{title:"Meeting",start:new Date(n,a,l-1,10,30),allDay:!1,className:"event-green"},{title:"Lunch",start:new Date(n,a,l+7,12,0),end:new Date(n,a,l+7,14,0),allDay:!1,className:"event-red"},{title:"Md-pro Launch",start:new Date(n,a,l-2,12,0),allDay:!0,className:"event-azure"},{title:"Birthday Party",start:new Date(n,a,l+1,19,0),end:new Date(n,a,l+1,22,30),allDay:!1,className:"event-azure"},{title:"Click for Creative Tim",start:new Date(n,a,21),end:new Date(n,a,22),url:"https://www.creative-tim.com/",className:"event-orange"},{title:"Click for Google",start:new Date(n,a,21),end:new Date(n,a,22),url:"https://www.creative-tim.com/",className:"event-orange"}]})},e.\u0275fac=function(t){return new(t||e)},e.\u0275cmp=i.Gb({type:e,selectors:[["calendar-cmp"]],decls:7,vars:0,consts:[[1,"main-content"],[1,"container-fluid"],[1,"row"],[1,"col-md-10","col-md-offset-1"],[1,"card","card-calendar"],[1,"card-content"],["id","fullCalendar"]],template:function(e,t){1&e&&(i.Sb(0,"div",0),i.Sb(1,"div",1),i.Sb(2,"div",2),i.Sb(3,"div",3),i.Sb(4,"div",4),i.Sb(5,"div",5),i.Nb(6,"div",6),i.Rb(),i.Rb(),i.Rb(),i.Rb(),i.Rb(),i.Rb())},encapsulation:2}),e}()}]}],o=function(){function e(){}return e.\u0275mod=i.Kb({type:e}),e.\u0275inj=i.Jb({factory:function(t){return new(t||e)},imports:[[l.c,a.f.forChild(c),r.f]]}),e}()}}]);
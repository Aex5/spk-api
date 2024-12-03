const { registerHandler } = require("./auth/register");
const { loginHandler } = require("./auth/login");
const { getDestinations } = require("./destination");
const { searchDestination } = require("./destination/search");
const profileHandler = require("./admin/profile");
const predictHandler = require("./destination/predict");
const authMiddleware = require("./middleware");
const predictHandler2 = require("./destination/predict2");
const { createEventHandler } = require("./event/create");
const { deleteEventHandler } = require("./event/delete");
const { getEvent } = require("./event");
const { registerBookingHandler } = require("./booking/register");
const { detailDestination } = require("./destination/detailDestination");
const { getUsers } = require("./users");
const { updateUser } = require("./users/update");
const { topDestination } = require("./destination/topdestination");
const { postCommentHandler } = require("./comments/create");
const { getComment } = require("./comments/index");
const { getUserComment } = require("./comments/userComents");
const { detailEvent } = require("./event/detailEvent");
const { detailEventUser } = require("./event/userEvent");
const { detailRegister } = require("./booking/detailRegister");

const routes = [
  {
    method: "GET",
    path: "/api",
    handler: (request, h) => {
      return "Hello, Hapi!";
    },
  },
  {
    method: "POST",
    path: "/api/register",
    handler: registerHandler,
  },
  {
    method: "POST",
    path: "/api/login",
    handler: loginHandler,
  },
  {
    method: "GET",
    path: "/api/destinations",
    handler: getDestinations,
  },
  {
    method: "GET",
    path: "/api/destination/{name}",
    handler: searchDestination,
  },
  {
    method: "GET",
    path: "/api/destination/detail/{id}",
    handler: detailDestination,
  },
  {
    method: "GET",
    path: "/api/destination/top",
    handler: topDestination,
  },

  //  comments
  {
    method: "POST",
    path: "/api/destination/{id}/comment",
    handler: postCommentHandler,
  },
  {
    method: "GET",
    path: "/api/user/{user_id}/comments",
    handler: getUserComment,
  },
  {
    method: "GET",
    path: "/api/destination/{destination_id}/comments",
    handler: getComment,
  },

  //  profile
  {
    method: "GET",
    path: "/api/user/{id}",
    handler: profileHandler,
  },
  {
    method: "POST",
    path: "/api/predict",
    handler: predictHandler,
  },
  {
    method: "POST",
    path: "/api/predict2",
    handler: predictHandler2,
  },

  // event
  {
    method: "GET",
    path: "/api/events",
    handler: getEvent,
  },
  {
    method: "POST",
    path: "/api/event/create",
    handler: createEventHandler,
  },
  {
    method: "DELETE",
    path: "/api/event/delete/{event_id}",
    handler: deleteEventHandler,
  },

  // booking
  {
    method: "POST",
    path: "/api/booking/register",
    handler: registerBookingHandler,
  },
  {
    method: "GET",
    path: "/api/booking/event/{event_id}",
    handler: detailRegister,
  },
  {
    method: "GET",
    path: "/api/booking/event/{event_id}/user/{user_id}",
    handler: detailEvent,
  },
  {
    method: "GET",
    path: "/api/booking/user/{user_id}",
    handler: detailEventUser,
  },

  //users
  {
    method: "GET",
    path: "/api/users",
    handler: getUsers,
  },
  {
    method: "PUT",
    path: "/api/users/update/{user_id}",
    handler: updateUser,
  },
];

module.exports = routes;

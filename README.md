# flags-api

An api for tracking and routing flags, comments, and ratings.

## API end-points/routes

| Verb   | URI Pattern            | Controller#Action |
| ----   | -----------            | ----------------- |
| POST   | `/sign-up`             | `users#signup`    |
| POST   | `/sign-in`             | `users#signin`    |
| DELETE | `/sign-out/:id`        | `users#signout`   |
| PATCH  | `/change-password/:id` | `users#changepw`  |
| GET    | `/ratings`             | `ratings#index`   |
| POST   | `/ratings`             | `ratings#create`  |
| GET    | `/ratings/:id`         | `ratings#show`    |
| PATCH  | `/ratings/:id`         | `ratings#update`  |
| DELETE | `/ratings/:id`         | `ratings#destroy` |
| GET    | `/comments`            | `comments#index`  |
| POST   | `/comments`            | `comments#create` |
| GET    | `/comments/:id`        | `comments#show`   |
| PATCH  | `/comments/:id`        | `comments#update` |
| DELETE | `/comments/:id`        | `comments#destroy`|
| GET    | `/flags`               | `flags#index`     |
| GET    | `/flags/:id`           | `flags#show`      |
| GET    | `/users`               | `users#index`     |
| GET    | `/users/:id`           | `users#show`      |

-   Prefix Verb   URI Pattern                    Controller#Action
-    ratings GET    /ratings(.:format)             ratings#index
-            POST   /ratings(.:format)             ratings#create
-     rating GET    /ratings/:id(.:format)         ratings#show
-            PATCH  /ratings/:id(.:format)         ratings#update
-            PUT    /ratings/:id(.:format)         ratings#update
-            DELETE /ratings/:id(.:format)         ratings#destroy
-   comments GET    /comments(.:format)            comments#index
-            POST   /comments(.:format)            comments#create
-    comment GET    /comments/:id(.:format)        comments#show
-            PATCH  /comments/:id(.:format)        comments#update
-            PUT    /comments/:id(.:format)        comments#update
-            DELETE /comments/:id(.:format)        comments#destroy
-      flags GET    /flags(.:format)               flags#index
-       flag GET    /flags/:id(.:format)           flags#show
-    sign_up POST   /sign-up(.:format)             users#signup
-    sign_in POST   /sign-in(.:format)             users#signin
-            DELETE /sign-out/:id(.:format)        users#signout
-            PATCH  /change-password/:id(.:format) users#changepw
-      users GET    /users(.:format)               users#index
-       user GET    /users/:id(.:format)           users#show

All data returned from API actions is formatted as JSON.

---

## User actions

*Summary:*

<table>
<tr>
  <th colspan="3">Request</th>
  <th colspan="2">Response</th>
</tr>
<tr>
  <th>Verb</th>
  <th>URI</th>
  <th>body</th>
  <th>Status</th>
  <th>body</th>
</tr>
<tr>
<td>POST</td>
<td>`/sign-up`</td>
<td><strong>credentials</strong></td>
<td>201, Created</td>
<td><strong>user</strong></td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>400 Bad Request</td>
  <td><em>empty</em></td>
</tr>
<tr>
<td>POST</td>
<td>`/sign-in`</td>
<td><strong>credentials</strong></td>
<td>200 OK</td>
<td><strong>user w/token</strong></td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>401 Unauthorized</td>
  <td><em>empty</em></td>
</tr>
<tr>
<td>DELETE</td>
<td>`/sign-out/:id`</td>
<td>empty</td>
<td>201 Created</td>
<td>empty</td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>401 Unauthorized</td>
  <td><em>empty</em></td>
</tr>
<tr>
<td>PATCH</td>
<td>`/change-password/:id`</td>
<td><strong>passwords</strong></td>
<td>204 No Content</td>
<td><strong>user w/token</strong></td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>400 Bad Request</td>
  <td><em>empty</em></td>
</tr>
</table>

### signup

The `create` action expects a *POST* of `credentials` identifying a new user to
 create, e.g. using `getFormFields`:

```html
<form>
  <input name="credentials[email]" type="text" value="an@example.email">
  <input name="credentials[password]" type="password" value="an example password">
  <input name="credentials[password_confirmation]" type="password" value="an example password">
</form>

```

or using `JSON`:

```json
{
  "credentials": {
    "email": "an@example.email",
    "password": "an example password",
    "password_confirmation": "an example password"
  }
}
```

The `password_confirmation` field is optional.

If the request is successful, the response will have an HTTP Status of 201,
 Created, and the body will be JSON containing the `id` and `email` of the new
 user, e.g.:

```json
{
  "user": {
    "id": 1,
    "email": "an@example.email"
  }
}
```

If the request is unsuccessful, the response will have an HTTP Status of 400 Bad
 Request, and the response body will be empty.

### signin

The `signin` action expects a *POST* with `credentials` identifying a previously
 registered user, e.g.:

```html
<form>
  <input name="credentials[email]" type="text" value="an@example.email">
  <input name="credentials[password]" type="password" value="an example password">
</form>
```

or:

```json
{
  "credentials": {
    "email": "an@example.email",
    "password": "an example password"
  }
}
```

If the request is successful, the response will have an HTTP Status of 200 OK,
 and the body will be JSON containing the user's `id`, `email`, and the `token`
 used to authenticate other requests, e.g.:

```json
{
  "user": {
    "id": 1,
    "email": "an@example.email",
    "token": "an example authentication token"
  }
}
```

If the request is unsuccessful, the response will have an HTTP Status of 401
 Unauthorized, and the response body will be empty.

### signout

The `signout` actions is a *DELETE* specifying the `id` of the user so sign out.

If the request is successful the response will have an HTTP status of 204 No
 Content.

If the request is unsuccessful, the response will have a status of 401
 Unauthorized.

### changepw

The `changepw` action expects a PATCH of `passwords` specifying the `old` and
 `new`.

If the request is successful the response will have an HTTP status of 204 No
 Content.

If the request is unsuccessful the reponse will have an HTTP status of 400 Bad
 Request.

---

The `sign-out` and `change-password` requests must include a valid HTTP header
 `Authorization: Token token=<token>` or they will be rejected with a status of
 401 Unauthorized.

## Example AJAX requests

```
const submitComment = (success, failure, content, flag_id) => {
  $.ajax({
    method: 'POST',
    url: app.api + '/comments/',
    headers: {
      Authorization: 'Token token=' + app.user.token,
    },
    data: {
      comment:  {
        content: content,
        user_id: app.user.id,
        flag_id: flag_id,
      },
    },
  }).done(success)
  .fail(failure);
};

const editComment = (success, failure, content, id) => {
  $.ajax({
    method: 'PATCH',
    url: app.api + '/comments/' + id,
    headers: {
      Authorization: 'Token token=' + app.user.token,
    },
    data: {
      comment:  {
        content: content,
      },
    },
  }).done(success)
  .fail(failure);
};

const deleteComment = (success, failure, id) => {
  $.ajax({
    method: 'DELETE',
    url: app.api + '/comments/' + id,
    headers: {
      Authorization: 'Token token=' + app.user.token,
    },
  }).done(success)
  .fail(failure);
};

const submitRating = (success, failure, score, flag_id) => {
  $.ajax({
    method: 'POST',
    url: app.api + '/ratings/',
    headers: {
      Authorization: 'Token token=' + app.user.token,
    },
    data: {
      rating: {
        score: score,
        user_id: app.user.id,
        flag_id: flag_id,
      },
    },
  }).done(success)
  .fail(failure);
};

const updateRating = (success, failure, score, id) => {
  $.ajax({
    method: 'PATCH',
    url: app.api + '/ratings/' + id,
    headers: {
      Authorization: 'Token token=' + app.user.token,
    },
    data: {
      rating: {
        score: score,
      },
    },
  }).done(success)
  .fail(failure);
};
```

## [License](LICENSE)

Source code distributed under the MIT license. Text and other assets copyright
General Assembly, Inc., all rights reserved.

export const createStep = (todo, step) => {
  return (
    $.ajax({
      url: `api/todos/${todo.id}/steps`,
      method: 'POST',
      data: {
        step
      },
    })
  );
};

// export const removeStep = (step) => {
//   return (
//     $.ajax({
//       url: `api/steps/${step.id}`,
//       method: 'DELETE',
//       data: {
//         step
//       }
//     })
//   );
// };

// export const updateStep = (todo, step) => {
//   return (
//     $.ajax({
//       url: `api/steps/${step.id}`,
//       method: 'PATCH',
//       data: {
//         step
//       }
//     })
//   );
// };

const stateFilter = (state1: boolean, state2: boolean): boolean => {
  return state1 === state2;
};

const userFilter = (id1: number, id2: number): boolean => {
  return id1 === id2;
};

const assigneeFilter = (assignees: Array<any>, id: number): boolean => {
  return !!assignees.filter((assignee) => assignee.user_id === id).length;
};

const commentFilter = (comments: Array<any>, id: number): boolean => {
  return !!comments.filter((comment) => comment.user_id === id).length;
};

const nullFilter = (value: any): any => {
  // eslint-disable-next-line no-restricted-syntax
  for (const property in value) {
    if (value[property] === null) value[property] = "";
  }
  return value;
};

export default { stateFilter, userFilter, assigneeFilter, commentFilter, nullFilter };

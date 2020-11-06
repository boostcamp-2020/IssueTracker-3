/* eslint-disable camelcase */
export interface Milestone {
  id: number | null;
  name: string;
  description: string;
  due_date: Date | null;
  created_at: Date;
}

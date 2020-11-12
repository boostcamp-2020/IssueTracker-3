/* eslint-disable camelcase */
export interface Milestone {
id: number | null;
name: string;
description: string;
state: boolean;
due_date: Date | null;
created_at: Date;
}

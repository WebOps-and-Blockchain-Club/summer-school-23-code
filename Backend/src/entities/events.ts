import { Entity, PrimaryGeneratedColumn, Column } from "typeorm";

@Entity({ name: "Events" })
export class Events {
  @PrimaryGeneratedColumn()
  event_id!: number;

  @Column()
  name!: string;

  @Column()
  description!: string;

  @Column()
  date!: string;

  @Column()
  exp_date!: string;

  @Column()
  user_id!: string;

  @Column()
  is_valid!: boolean;
}

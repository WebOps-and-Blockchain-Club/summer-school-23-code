import { Entity, PrimaryGeneratedColumn, Column } from "typeorm";

@Entity({ name: "Events" })
export class Events {
    @PrimaryGeneratedColumn("uuid")
    event_id!: string;

    @Column()
    name!: string;

    @Column()
    date!: string;

    @Column()
    exp_date!: string;

    @Column()
    user_id!: string;

    @Column()
    is_valid!: boolean;
}
import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from "typeorm";
import { User } from "./user";

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
}
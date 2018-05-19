package com.domain;

import javax.persistence.*;

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "post_type",discriminatorType = DiscriminatorType.STRING)
@DiscriminatorValue("2")
public class MainPost extends Post {
}

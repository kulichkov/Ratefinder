package orm;

import javax.persistence.*;

/**
 * Created by Nikit on 17.03.2016.
 */
@Entity
@Table(name = "keywords", schema = "ratefinder")
public class KeywordsEntity {
    private int id;
    private String name;
    private PersonsEntity person;

    @Id
    @Column(name = "ID")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "Name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @ManyToOne
    @JoinColumn(name = "PersonID")
    public PersonsEntity getPerson() {
        return person;
    }

    public void setPerson(PersonsEntity person) {
        this.person = person;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        KeywordsEntity that = (KeywordsEntity) o;

        if (id != that.id) return false;
        if (!person.equals(that.person)) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + person.hashCode();
        return result;
    }
}

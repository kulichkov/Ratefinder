package orm;

import javax.persistence.*;

/**
 * Created by Nikit on 17.03.2016.
 */
@Entity
@Table(name = "personpagerank", schema = "ratefinder")
public class PersonPageRankEntity {
    private int id;
    private PersonsEntity person;
    private PagesEntity page;
    private int rank;

    @Id
    @Column(name = "Id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @ManyToOne
    @Column(name = "PersonId")
    public PersonsEntity getPerson() {
        return person;
    }

    public void setPerson(PersonsEntity person) {
        this.person = person;
    }

    @ManyToOne
    @Column(name = "PageId")
    public PagesEntity getPage() {
        return page;
    }

    public void setPage(PagesEntity page) {
        this.page = page;
    }

    @Basic
    @Column(name = "Rank")
    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PersonPageRankEntity that = (PersonPageRankEntity) o;

        if (!person.equals(person)) return false;
        if (!page.equals(page)) return false;
        if (rank != that.rank) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = person.hashCode();
        result = 31 * result + page.hashCode();
        result = 31 * result + rank;
        return result;
    }
}

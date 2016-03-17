package orm;

import javax.persistence.*;
import java.sql.Timestamp;
import java.sql.Date;

/**
 * Created by Nikit on 17.03.2016.
 */
@Entity
@Table(name = "pages", schema = "ratefinder")
public class PagesEntity {
    private int id;
    private String url;
    private SitesEntity site;
    private Timestamp foundDateTime;
    private Date lastScanDate;

    @Id
    @Column(name = "ID")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "Url")
    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @ManyToOne
    @Column(name = "SiteID")
    public SitesEntity getSite() {
        return site;
    }

    public void setSite(SitesEntity site) {
        this.site = site;
    }

    @Basic
    @Column(name = "FoundDateTime")
    public Timestamp getFoundDateTime() {
        return foundDateTime;
    }

    public void setFoundDateTime(Timestamp foundDateTime) {
        this.foundDateTime = foundDateTime;
    }

    @Basic
    @Column(name = "LastScanDate")
    public Date getLastScanDate() {
        return lastScanDate;
    }

    public void setLastScanDate(Date lastScanDate) {
        this.lastScanDate = lastScanDate;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PagesEntity that = (PagesEntity) o;

        if (id != that.id) return false;
        if (!site.equals(that.site)) return false;
        if (url != null ? !url.equals(that.url) : that.url != null) return false;
        if (foundDateTime != null ? !foundDateTime.equals(that.foundDateTime) : that.foundDateTime != null)
            return false;
        if (lastScanDate != null ? !lastScanDate.equals(that.lastScanDate) : that.lastScanDate != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (url != null ? url.hashCode() : 0);
        result = 31 * result + site.hashCode();
        result = 31 * result + (foundDateTime != null ? foundDateTime.hashCode() : 0);
        result = 31 * result + (lastScanDate != null ? lastScanDate.hashCode() : 0);
        return result;
    }
}

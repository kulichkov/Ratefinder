package orm;

import java.util.List;

/**
 * Created by Nikit on 17.03.2016.
 */
public interface RepositoryInterface<T> {
    List<T> getAll();
    boolean save(T entity);
    boolean delete(int id);
    boolean delete(T entity);
}

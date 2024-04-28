import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout';
import {Head, Link} from '@inertiajs/react';
import {PageProps} from '@/types';
import axios from "axios";
import {useEffect, useState} from "react";
import DeleteButton from "@/Pages/Books/DeleteButton";
import InfiniteScroll from "react-infinite-scroller";
import Loader from "@/Components/Loader";

export default function Index({auth, ...rest}: PageProps<any>) {

    const [loading, setLoading] = useState(false)
    const [books, setBooks] = useState<any>([]);
    const [hasMore, setHasMore] = useState(true);
    const [currentPage, setCurrentPage] = useState(1);

    const fetchBooks = async (page: any) => {
        try {
            let config = {
                method: 'get',
                maxBodyLength: Infinity,
                url: `/api/books?page=${page}`,
                headers: {
                    'Accept': 'application/json',
                },
            };
            const data = await axios.request(config)
            setBooks((prevBooks: any) => [...prevBooks, ...data.data.data]);
            setCurrentPage(page);
            setHasMore(data.data.current_page < data.data.last_page);
        } catch (error) {
            alert(JSON.stringify(error));
            console.error('Error fetching books:', error);
        }
    };

    useEffect(() => {
        setLoading(true)
        fetchBooks(currentPage)
            .then(value => value)
            .finally(() => {
                setLoading(false)
            })
    }, []);

    const loadMore = async () => {
        await fetchBooks(currentPage + 1);
    };

    return (
        <AuthenticatedLayout
            user={auth.user}
            {...rest}
            header={<h2 className="font-semibold text-xl text-gray-800 leading-tight">All Books</h2>}
        >
            <Head title="Dashboard"/>

            <div className="py-12">
                <div className="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div className="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                        <div className="p-6 text-gray-900">
                            {loading && (
                                <Loader/>
                            ) || (
                                <>
                                    {(books.length > 0) && (
                                        <div className="overflow-x-auto">
                                            <InfiniteScroll
                                                pageStart={0}
                                                loadMore={loadMore}
                                                hasMore={hasMore}
                                                loader={<div key={'loader'}
                                                             className={'flex justify-center items-center'}>Loading...</div>}
                                            >
                                                <table className="table-auto min-w-full divide-y divide-gray-200">
                                                    <thead>
                                                    <tr>
                                                        <th className="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">#</th>
                                                        <th className="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Title</th>
                                                        <th className="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Writer</th>
                                                        <th className="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Cover
                                                            Image
                                                        </th>
                                                        <th className="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Point</th>
                                                        <th className="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Tags</th>
                                                        <th className="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Edit</th>
                                                        <th className="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Delete</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody className="bg-white divide-y divide-gray-200">
                                                    {books.map((book: any, index: number) => (
                                                        <tr key={`book-${book.id}-${index}`}>
                                                            <td className="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-500">{index + 1}</td>
                                                            <td className="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-500">
                                                                <Link
                                                                    className={'text-indigo-600 hover:text-indigo-900'}
                                                                    href={route('book-show', book.id)}>{book.title}</Link>
                                                            </td>
                                                            <td className="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-500">{book.writer}</td>
                                                            <td className="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-500">
                                                                <Link href={route('book-show', book.id)}>
                                                                    <img src={book.cover_image} alt={book.title}
                                                                         width={50}
                                                                         height={50}/>
                                                                </Link>
                                                            </td>
                                                            <td className="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-500">${book.point}</td>
                                                            <td className="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-500">{book.tags}</td>
                                                            <td className="px-6 py-4 whitespace-no-wrap text-sm leading-5">
                                                                <Link href={`/books/${book.id}/edit`}
                                                                      className="text-indigo-600 hover:text-indigo-900 font-medium">Edit</Link>
                                                            </td>
                                                            <td className="px-6 py-4 whitespace-no-wrap text-sm leading-5 font-medium">
                                                                <DeleteButton
                                                                    {...{
                                                                        id: book.id,
                                                                        books,
                                                                        setBooks
                                                                    }}
                                                                />
                                                            </td>
                                                        </tr>
                                                    ))}
                                                    </tbody>
                                                </table>
                                            </InfiniteScroll>
                                        </div>
                                    ) || (
                                        <div>Not Found!</div>
                                    )}
                                </>
                            )}
                        </div>
                    </div>
                </div>
            </div>
        </AuthenticatedLayout>
    );
}
